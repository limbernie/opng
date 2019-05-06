#!/bin/bash

TEMP=$(mktemp -u)

for png in *.png; do
	echo $png
	convert -strip -alpha Remove $png $png
	pngquant $png
done > $TEMP

for png in $(cat $TEMP); do
	rm $png
	mv "${png%*.png}-fs8.png" $png
done

rm -f $TEMP
