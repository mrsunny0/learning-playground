#!/bin/bash

# echo paramters
# echo "Parameter $1"
# echo "Parameter $2"
# echo "Parameter $3"

# while loop
# while [[ true ]]
# do
#     echo "${RANDOM::3}"
#     sleep 0.2
# done

while [[ "${#}" > 0 ]]
do
    echo "Number of parameters: ${#}"
    echo "Parameter $1"
    echo "Parameter $2"
    echo "Parameter $3"
    shift
done