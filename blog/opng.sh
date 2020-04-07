#!/bin/bash

TEMP=$(mktemp -u)

for png in *.png; do
	echo "${png}"
    echo "${png%*.png}-small.png"
	convert -strip -alpha Remove "${png}" "${png}"
    convert -resize 33% "${png}" "${png%*.png}-small.png"
	pngquant "${png}"
    pngquant "${png%*.png}-small.png"
done > $TEMP

for png in $(cat $TEMP); do
	rm "${png}"
	mv "${png%*.png}-fs8.png" "${png}"
done

rm -f $TEMP
