#!/bin/bash

FILES=$@

for md in $(readlink -f $FILES); do
    ./image-responsive.sh $md
    ./image-popup.sh $md
done
