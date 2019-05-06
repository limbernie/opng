#!/bin/bash

# grab my password
read -p "Password: " PASS
TEMP=$(mktemp -u)
echo -n $PASS | sha512sum | cut -d' ' -f1 > $TEMP

# decipher images
for png in *.png; do
	convert -decipher $TEMP $png $png
done

# clean up
rm -f $TEMP
