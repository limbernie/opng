#!/bin/bash

FILES=$@

for img in $(readlink -f $FILES); do
    if [ "${img#*.}" == "jpg" ]; then
        convert -strip \
                -sampling-factor 4:2:0 \
                -quality 85 \
                -interlace JPEG \
                -colorspace sRGB \
                -resize 800 \
                "${img}" "${img}" &&
        cwebp -quiet "${img}" -o "${img%*.jpg}".webp
    else
        convert -resize 800 \
                -strip \
                -alpha Remove \
                "${img}" "${img}" &&
        cwebp -quiet "${img}" -o "${img%*.png}".webp
    fi
done
