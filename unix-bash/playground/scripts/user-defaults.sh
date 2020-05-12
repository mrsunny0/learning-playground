#!/bin/bash

# while getopts abc: OPTION
# do
#     case $OPTION in 
#         a) ;;
#         b) ;;
#         c) echo $OPTARG ;;
#     esac
# done

# shift "$((OPTIND - 1))"

# echo "$@"

# echo "$@"
# opts=(getopt -o a::b:cde --long file::,name:,help -- "@")
# eval set -- "$opts"
# echo "$@"

# echo "All arguments: $@"

# opts=$( getopt -o a::b:cde --long file::,name:,help -- "$@" )
# eval set -- "$opts"

# echo "All new arguments: $@"

ARRAY=(one two three)

echo "${!ARRAY[@]}"
echo "${#ARRAY[@]}"
echo "${#ARRAY[0]}"

for i in "${!ARRAY[@]}"
do  
    echo "${ARRAY[$i]}"
done

for i in {1..5}
do
  ARRAY=("${ARRAY[@]}" $i)
done
echo "${ARRAY[@]}"



VARIABLE=100
function name() {
    echo "does this work"
}

function hello {
    echo "hello"
}

goodbye() {
    echo "goei"
    local VARIABLE=200
    return $VARIABLE
}

name
hello
goodbye
echo $?
echo $VARIABLE