#!/bin/bash

TEMP="$(mktemp -u)"

for png in *.png; do
    echo "${png}"
    convert -strip -alpha Remove "${png}" "${png}"
    pngquant "${png}"

    if [ "$(identify -format %w "${png}")" -ge 800 ]; then
        echo "${png%*.png}-20vw.png"
        echo "${png%*.png}-40vw.png"
        echo "${png%*.png}-60vw.png"
        convert -resize 20% "${png}" "${png%*.png}-20vw.png"
        convert -resize 40% "${png}" "${png%*.png}-40vw.png"
        convert -resize 60% "${png}" "${png%*.png}-60vw.png"
        pngquant "${png%*.png}-20vw.png"
        pngquant "${png%*.png}-40vw.png"
        pngquant "${png%*.png}-60vw.png"
    fi
done > $TEMP

for png in $(cat $TEMP); do
	rm "${png}"
	mv "${png%*.png}-fs8.png" "${png}"
done

rm -f $TEMP
