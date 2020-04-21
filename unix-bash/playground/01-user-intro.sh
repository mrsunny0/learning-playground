#!/bin/bash

# Hello from the main OS
WORD='word'
echo ${WORD}

# Display user and ID
echo "Your UID is ${UID}" 

# Display username
# use id command
# id -u -n
# whoami

# print them out
# USER_NAME=$(id -un)
USER_NAME=`(id -un)`
echo "Your username is ${USER_NAME}"

# Display if user is root or not
# note the spacing in the brackets
# if [[ "${UID}" -eq 0 ]]
if [[ "${UID}" == 0 ]]
then 
    echo "You are root"
else
    echo "You are not root"
fi