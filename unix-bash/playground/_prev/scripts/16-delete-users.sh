#!/bin/bash

# removes users, disables or archives their files
# arguments should be
# v = verbose
# d = disable
# a = archive
# command line argument for username

# verbose function
function verbose() {
    VERBOSE="true"
    echo $1 >&1
}

# usage statement 
function usage() {
    echo "This is how you should use this script $0..." >&2
    exit 1
}

# check root 
if [[ $UID != 0 ]]
then 
    echo "You do not have root privileges" >&2
    exit 1
fi

# loop through command line options
while getopts vda: OPTION
do 
    case $OPTION in
        v) verbose "enabling verbose" ;;
        d) verbose "disabling account" ;;
        a) ARCHIVE_NAME=$OPTARG; verbose "archiving account" ;;
        ?) usage ;;
    esac
done
    
# get command line arguments
shift $(( OPTIND - 1 ))
if [[ $# == 0 ]]
then   
    echo "You did not supply a username" >&2
    usage
fi

# print command line arguments
for USERNAME in "$@"
do  
    echo $USERNAME
    # n is true if NOT empty
    # z is true if empty
    if [[ ! -z $ARCHIVE_NAME ]] 
    then   
        echo "This is your archive name $ARCHIVE_NAME"
    fi
done