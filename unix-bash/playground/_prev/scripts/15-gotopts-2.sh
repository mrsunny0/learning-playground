#!/bin/bash

# read inline arguments
while getopts abc:d: opt
do
    case $opt in
        a)
            echo $opt
            ;;
        b)  
            echo $opt
            ;;
        d | c) 
            echo $opt
            echo $OPTARG
            ;;
    esac
done

# shift arguments to get command line arguments
shift $(( OPTIND - 1 ))

# read command line arguments
echo
echo "The number of commands are $#"
echo
for arg in "$@"
do
    echo $arg
done