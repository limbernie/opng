#!/bin/bash

FILES=$@

for md in $(readlink -f $FILES); do
    ./image-popup.sh $md
    ./image-responsive.sh $md
done
