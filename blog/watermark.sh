#!/bin/bash

AUTHOR="Bernie Lim"
YEAR=$(date +%Y)
COPYRIGHT="© $YEAR $AUTHOR"

convert -size 300x50 xc:grey30 \
        -font Helvetica \
        -pointsize 20 \
        -gravity center \
				-draw "fill grey70  text 0,0  '$COPYRIGHT'" \
				stamp_fgnd.png

convert -size 300x50 xc:black \
        -font Helvetica \
        -pointsize 20 \
        -gravity center \
				-draw "fill white  text  1,1  '$COPYRIGHT'  \
        									 text  0,0  '$COPYRIGHT'  \
							 fill black  text -1,-1 '$COPYRIGHT'" \
				+matte stamp_mask.png

composite -compose CopyOpacity stamp_mask.png stamp_fgnd.png stamp.png

mogrify -trim +repage stamp.png

convert -resize 400x400 -rotate '-45' -transparent white stamp.png stamp.png

pngquant stamp.png; rm stamp.png && mv stamp-fs8.png stamp.png

rm stamp_mask.png stamp_fgnd.png
