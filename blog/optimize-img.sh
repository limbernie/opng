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
        if [ $(identify -format "%w" "${img}") -ge 800 ]; then
            convert -resize 800 \
                    -strip \
                    -alpha Remove \
                    "${img}" "${img}"
        else
            convert -strip \
                    -alpha Remove \
                    "${img}" "${img}"
        fi
        pngquant "${img}"; rm "${img}"; mv "${img%*.png}"-fs8.png "${img}" &&
        cwebp -quiet "${img}" -o "${img%*.png}".webp
    fi
done
