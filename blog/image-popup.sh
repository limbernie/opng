#!/bin/bash

FILES=$@
PATTERN='(png|jpg|gif)\)$'
OPEN='<a class="image-popup">'
CLOSE='</a>'

for md in $(readlink -f $FILES); do
  sed -i -r \
      -e "/$PATTERN/i \\$OPEN" \
      -e "/$PATTERN/a \\$CLOSE" \
      $md
done
