#!/bin/bash

while getopts abc OPTION
do
    case $OPTION in 
        a) echo "a";;
        b) echo "b";;
        c) echo "c";;
        ?) echo "not correct"; exit 1;;
    esac
done

shift $(($OPTIND - 1))

# while [[ $# != 0 ]]
# do
#     case $1 in
#         --along) echo "a";;
#         --blong) echo "b";;
#         --clong) echo "c";;
#         ?) echo "not correct"; exit 1;;
#     esac
#     shift
# done

echo "$@"