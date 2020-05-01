#!/bin/bash

# get the script arguments
SCRIPT_ARGS=$@

# making a function accept arguments
function log() {
    echo "You called the log function with args $@"
    for i in "${SCRIPT_ARGS}"
    do  
        echo $i
    done

    local MESSAGE="${@}"
    echo $MESSAGE

}

# function uses variables after initiation
function after_the_fact() {
    if [[ ${VERBOSE} == "true" ]]
    then
        echo "verbose is set"
    fi
}

VERBOSE=true
after_the_fact

# function for local variables
function ignore_the_fact() {
    local VERBOSE=$1
    shift
    echo $VERBOSE
}

echo $VERBOSE
ignore_the_fact 1
echo $VERBOSE

# making variables readonly
# constant variables
readonly VERBOSE='true'

function backup_file() {
    local FILE=$1

    # make sure it exists
    if [[ -f ${FILE} ]]
    then
        # create temporary storate file path
        local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"

        # copy, and preserve properties
        # such as date and permissiosn
        cp -p ${FILE} ${BACKUP_FILE}
    else
        return 1
    fi
}

backup_file "13-functions.sh"

# check status
if [[ $? == 0 ]]
then   
    echo "succeeded"
else
    echo "failed"
fi

# remove files in tmp
for i in /var/tmp/*
do
    echo "removing file $(basename ${i})"
    rm $i
done