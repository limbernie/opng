#!/bin/bash

FILES=$@

for md in $(readlink -f $FILES); do
  sed -i \
      -r \
      -e 's/^#+ Background/## Background/' \
      -e 's/^#+ Information Gathering/## Information Gathering/' \
      -e 's/^#+ Low-Privilege Shell/## Low-Privilege Shell/' \
      -e 's/^#+ Privilege Escalation/## Privilege Escalation/' \
      -e 's/^#+ Afterthought/## Afterthought/' \
      -e '/^#+ (On this post|Background|Information Gathering|Low-Privilege Shell|Privilege Escalation|Afterthought)/! s/^## (.*)/### \1/' $md
done
