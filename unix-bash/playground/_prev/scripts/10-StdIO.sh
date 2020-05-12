#!/bin/bash

read X < $(pwd)/01-user-intro.sh

echo
echo "${X}"
echo

# using file descriptors (FD)
# 0 = STDIN
# 1 = STDOUT
# 2 = STDERR
read X 0< $(pwd)/01-user-intro.sh
echo
echo "${X}"
echo

# error
head -n1s "/fake/path" 2> err.txt

# handle error and stdout at the same time
head -n1 "01-user-intro.sh" "/fake/path" > stdout.txt 2> err2.txt

# loop through and find any txt files
for f in $(pwd)/*
do 
    # get basename 
    BASENAME=$(basename $f)
    EXTENSION=${f##*.}
    # echo
    # echo ${BASENAME}
    # echo ${EXTENSION}
    # echo    
    if [[ "${EXTENSION}" == "txt" ]]
    then
        echo "DELETING FILE ${f}"
        rm ${f}
    fi
done

# using & for stdout and stderr 
head -n1 /fake/path > head.txt 2>&1
head -n1 /fake/path &>> head.txt 
cat "head.txt"

cat "head.txt" "fake.file" &>> head.txt
echo
cat head.txt

# passing stdout, but not error in pipe
echo
head -n3 /etc/passwd /fakefile | cat -n

# passing stdout and error in pipe
echo
head -n3 /etc/passwd /fakefile |& cat -n

# sending output to stderr, and let the user handle which to output to
echo "This should go in error" >&2

# #>, spcifies which STD to pipe, its either 1 for STDOUT or 2 STDERR
# >&# specifies which STD to go into in the calling script

# null device
echo
echo "Sending to null device"
head -n1 /etc/passwd /fakefile &>> error.text
# check exit status to see if this worked or not