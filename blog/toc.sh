#!/bin/bash

FILES=$@

for md in $(readlink -f $FILES); do

if grep '\{:toc\}' $md &>/dev/null; then
  exit
fi

sed -ir '/<!--more-->/a \
\
## On this post \
{:.no_toc} \
\
* TOC \
{:toc}' $md

done
