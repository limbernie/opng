#!/bin/bash

# Front matter
OPNG=$(readlink -f `dirname $0`)
TEMP=$(mktemp -u)
WATERMARK=watermark.sh

# Generate the stamp
./$WATERMARK

# Stamp it
cd $OPNG
for png in *.png; do
	echo $png
	height=$(identify $png | cut -d' ' -f3 | cut -d'x' -f2)
	if [ $height -lt 100 ]; then
		convert -resize $height stamp.png - | composite -gravity West - $png $png
	elif [ $height -lt 320 ]; then
		convert -resize $height stamp.png - | composite -gravity Center - $png $png
	else
		composite -gravity Center stamp.png $png $png
	fi
	convert -strip -alpha Remove $png $png
	pngquant $png
done > $TEMP

for png in $(cat $TEMP); do
	rm $png
	mv "${png%*.png}-fs8.png" $png
done

rm -f $TEMP
