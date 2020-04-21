#!/bin/bash

# if else
# if [[ $# != 0 ]]
# then
#     if [[ $1 == 0 ]]
#     then 
#         echo "element 0"
#     elif [[ $1 == 1 ]]
#     then
#         echo "element 1"
#     fi
# else 
#     echo "you did not supply any arguments" >&2
#     echo "this is going to stdout" >&1
#     exit 1
# fi

case $1 in 
    # look for the word before )
    # ;; to break
    start)
        echo "Starting"
        ;;
    hello)
        echo "HELLO"
        ;;
    *)
        echo "not right"
        ;;
esac

echo

case $1 in 
    # look for the word before )
    # ;; to break
    start)
        echo "Starting"
        ;;
    hello|goodbye)
        echo "HELLO"
        ;;
    *)
        echo "not right"
        ;;
esac

