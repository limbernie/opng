#!/bin/bash

FILES=$@
PATTERN="(png|jpg|gif)\)$"

for md in $(readlink -f $FILES); do
    sed -i -r "s/\!\[(.*)\]\((.*)\)/\{% include image.html image_alt=\"\1\" image_src=\"\2\" %\}/" \
    $md
done
