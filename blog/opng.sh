#!/bin/bash

TEMP="$(mktemp -u)"

for png in *.png; do
    echo "${png}"
    convert -strip -alpha Remove "${png}" "${png}"
    pngquant "${png}"

    if [ "$(identify -format %w "${png}")" -ge 800 ]; then
        echo "${png%*.png}-s.png"
        convert -resize 480 "${png}" "${png%*.png}-s.png"
        pngquant "${png%*.png}-s.png"
    else
        echo "${png%*.png}-s.png"
        cp "${png}" "${png%*.png}-s.png"
        pngquant "${png%*.png}-s.png"
    fi
done > $TEMP

for png in $(cat $TEMP); do
	rm "${png}"
	mv "${png%*.png}-fs8.png" "${png}"
done

rm -f $TEMP
