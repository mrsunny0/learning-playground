#!/bin/bash

# check if there is root privileges
if [[ ${UID} != 0 ]]
then
    echo "You do not have root privileges"
    exit 1
fi

# Get name and print back
read -p 'What is your username: ' NAME
echo "This is your name ${NAME}"

# check exit status
if [[ "$?" == 0 ]]
then
    echo "Executed successfully"
else
    echo "Did not execute correctly"
    exit 1
fi