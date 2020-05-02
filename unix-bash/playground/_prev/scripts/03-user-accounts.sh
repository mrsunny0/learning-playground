#!/bin/bash

# Create an account on the local system
# prompted with username and password

# Ask for username
read -p 'Enter the username to create ' USER_NAME

# Ask for the real name of user
read -p 'Enter the name of the person ' COMMENT

# Ask password
read -p 'Enter the password ' PASSWORD

# Create the user
useradd -c "${COMMENT}" -m ${USER_NAME}

# Set the password
# echo ${PASSWORD} | passwd ${USER_NAME}
passwd ${USER_NAME}

# Force the user to change password the first time they log in
# passwd -e ${USER_NAME}

# check process ps-ef