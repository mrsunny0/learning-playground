#!/bin/bash

# 
FILE=$1
LIMIT=${2:-100}

if [[ ! -f $FILE ]] 
then
    echo "Your file does not exists"
    exit 1
fi

# # Count the number of times
# IP=$(head -n $LIMIT syslog-sample | grep Failed $FILE | awk '{print $(NF - 3)}')

# # sort and count
# SORT_IP=$(echo $IP | sed 's/\s/\n/2' | sort -n | uniq -c | sort -rn)

# # echo
# echo $SORT_IP

# clear

grep Failed $FILE | awk '{print $(NF - 3)}' | sort | uniq -c | sort -nr | while read COUNT IP;
do
    if [[ $COUNT > $LIMIT ]]
    then
        echo $COUNT, $IP > /dev/null
    fi
done

# use while read in conjunction with loops and awk, reads in sorted data

# only get the first two columns in text.csv
grep -v '^header' text.csv | awk -F '^' '{print $1}' | sort -n -k 1 | uniq -c | sort | while read COUNT VALUE
do 
    echo -e $COUNT '\t' $VALUE
done

# VAR=$(cat /etc/passwd)
# echo "$VAR"

# get sume
OUTPUT=$(grep -v '^header' text.csv | awk -F '^' '{print $1}')

echo "$OUTPUT" | awk '{sum+=$1} END {print sum/NR}'

# ROWS AND COLUMNS
head -n 100 syslog-sample | awk '{print NR,"->",NF}' 

