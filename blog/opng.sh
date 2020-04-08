#!/bin/bash

TEMP="$(mktemp -u)"

for png in *.png; do
    echo "${png}"
    convert -strip -alpha Remove "${png}" "${png}"
    pngquant "${png}"

    if [ "$(identify -format %w "${png}")" -ge 800 ]; then
        echo "${png%*.png}-320w.png"
        echo "${png%*.png}-480w.png"
        echo "${png%*.png}-600w.png"
        convert -resize 320 "${png}" "${png%*.png}-320w.png"
        convert -resize 480 "${png}" "${png%*.png}-480w.png"
        convert -resize 600 "${png}" "${png%*.png}-600w.png"
        pngquant "${png%*.png}-320w.png"
        pngquant "${png%*.png}-480w.png"
        pngquant "${png%*.png}-600w.png"
    fi
done > $TEMP

for png in $(cat $TEMP); do
	rm "${png}"
	mv "${png%*.png}-fs8.png" "${png}"
done

rm -f $TEMP
