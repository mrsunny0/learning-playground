#!/bin/bash

# check to see if root user
if [[ "${UID}" == 0 ]]
then
    echo
    echo "Confirming you have root privileges"
    echo
else
    echo "You do not have root privileges"
    exit 1
fi

# must supply at least 1 argument
if (( $# < 1 ))
then
    echo "You did not supply an argument"
    echo
    read -p "Please add an input now: " USER_INPUT
    echo
    echo "Your argument is ${USER_INPUT}"
    echo
    # exit 1
else
    USER_INPUT="$1"
    # shift commands and intake anything else
    shift
    COMMENTS="$@"
fi

# generate password
# PASSWORD=${RANDOM}
PASSWORD=$(date +%s%N | sha256sum | head -c 50)

# check if password generation was okay
if (( $? != 0 ))
then
    echo "PASSWORD generation failed"
    exit 1
else 
    echo
    echo "PASSWORD generation succeeded: ${PASSWORD}"
    echo
fi 

# These are your comments
echo "Comments are: ${COMMENTS}"
echo
