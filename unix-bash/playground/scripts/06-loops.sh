#!/bin/bash

# Display what was executed
COMMAND=$0
echo "You execuded this command ${COMMAND}"

# Display the first parameter
echo "You execuded provided this command $1"

# display the basename
BASENAME=$(basename $0)
echo ${BASENAME}

# display the directory
DIR=$(dirname $0)
echo ${DIR}

# Tell them how many arguments were passed
NUMBER_OF_PARAMS=$#
echo ${NUMBER_OF_PARAMS}

# looping through params
# [[ ]] for string comparison
# (( )) for numeric comparison
if (( $# != 0 ))
then   
    for i in $@
    do
        echo $i
    done
else 
    echo "You supplied no params"
    exit 1
fi

# testing difference between $@ and $*
# note the use of quotation marks
for i in "$@"
do
    echo $i
done

for i in "$*"
do 
    echo $i
done

# extra, store array of new 
for i in *
do
    z=(${z[@]} $i)
done
echo ${z[@]}