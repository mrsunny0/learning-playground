#!/bin/bash

FILE="/home/vivek/lighttpd.tar.gz"
basename "$FILE"
f="$(basename -- $FILE)"
echo "$f"

FILE="/home/vivek/lighttpd.tar.gz"
echo ${FILE##*/}
## another example ##
url="https://www.cyberciti.biz/files/mastering-vi-vim.pdf"
echo "${url##*/}"

echo "${url#*/}"

echo ${FILE%%.*}
