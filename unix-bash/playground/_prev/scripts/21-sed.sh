#!/bin/bash

# sed 's/assistant/assistant to the/' manager.txt

# sed 's/[&$>^]/  /g' text.csv

# awk FS='^' OFS='---' '$1=$1' text.csv

# sed 's/[&$>^]/  /{3,4}' text.csv

# sed -i.backup 's/[&$>^]/  /4' text.csv

# echo '/home/user/' | sed 's#home#new/substitution/string#'
# echo '/home/user/' | sed 's:home:new/substitution/string:'

# cat text.csv | sed -e 1d -e 's/\^/  /g'
# cat text.csv | sed -e 1d -e '/^1/ s/\^/  /2,3'
START=${1:-2}
cat text.csv | sed -e 1d -e "${START} s/\^/  /g"