#!/bin/bash

if [[ ${UID} != 0 ]]
then
    # send to STDERR
    echo "You do not have root privileges" >&2
    echo "This is going to go to the stdout" >&1
    exit 1
else 
    # send to STOUT
    echo "You do have root privileges" >&1
fi

echo
echo "not displaying any echo, going to null device"
ls &> /dev/null
echo