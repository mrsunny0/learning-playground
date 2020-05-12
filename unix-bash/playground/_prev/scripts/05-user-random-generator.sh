#!/bin/bash

# generates list of random passwords
PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo ${PASSWORD::10}

# generate password based on time
PASSWORD=$(date +%s)
echo ${PASSWORD}

# generate password based on nanoseconds
PASSWORD=$(date +%N)
echo ${PASSWORD}

# sha randomize
function generate_random() {
    # echo $1
    RAND=$(date +%sN | sha256sum | head -c $1)
    echo ${RAND}
}

for i in {0..50}
do
    generate_random $i
done

# cannot override bash keywords
echo ${RANDOM}
RANDOM="HELLO"
echo ${RANDOM} # still a randomized number