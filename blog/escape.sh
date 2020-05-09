#!/bin/bash

sed -r 's/(\s?[a-zA-Z`]+)(\x27[a-z]+\s)/\1\\\2/g' $@
