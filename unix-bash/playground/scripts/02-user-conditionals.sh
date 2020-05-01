#!/bin/bash

# Display UID
echo "Your UID is ${UID}"

# Display if not match 1000 (need root)
UID_NULL="1000"
if [[ ${UID} != ${UID_NULL} ]]
then
    echo "You are the root"
else
    exit 1
fi

# Display the username
USER_NAME=$(id -un)
echo "Your user id is: ${USER_NAME}"

# Test if the command succeeded
# ${?} is a special command that gets the latest output exit command
# 0 exit command means it worked
if [[ ${?} != 0 ]]
then
    echo "This command did not work"
    exit 1
else 
    echo "The command worked"
fi

# Test against a string
USER_NAME_TEST="username"

if [[ ${USER_NAME} == ${USER_NAME_TEST} ]]
then
    echo "You are named ${USER_NAME_TEST}"
else
    echo "You are not named \"${USER_NAME_TEST}\""
fi

# Test for !=
if [[ ${USER_NAME} != ${USER_NAME_TEST} ]]
then
    echo "Username does not match"
    # exit 1
fi

exit 0