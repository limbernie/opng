#!/bin/bash

FILES=$@

for img in $(readlink -f $FILES); do
  convert -strip \
          -sampling-factor 4:2:0 \
          -quality 85 \
          -interlace JPEG \
          -colorspace sRGB \
          -resize 800 \
          $img $img
done
