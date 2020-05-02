#!/bin/bash

# generate a random password
# set password length with -L
# set password special character -s
# verbosity mode enabled with -v

# usage function
function usage() {
    echo "USAGE ${0} [-vs] [-l LENGTH]" >&2
    echo "Generate random password"
    echo "  -l LENGTH   specify the password length."
    echo "  -s          Append a special character to password."
    echo "  -v          Increase verbosity."
    exit 1
}

function log() {
    local MESSAGE="${@}"
    if [[ "${VERBOSE}" == "true" ]]
    then 
        echo "${MESSAGE}"
    fi
}

# set default value for password 
LENGTH=48
while getopts vl:s OPTION
do 
    case ${OPTION} in
        v)
            VERBOSE="true"
            log "Verbose mode on"
            # echo "Optional argument for v is: ${OPTARG}"
            ;;
        l)
            LENGTH="${OPTARG}"
            log "Length of password ${LENGTH}"
            ;;
        s) 
            USE_SPECIAL_CHARACTER="true"
            # echo "Optional argument for s is: ${OPTARG}"
            ;;
        ?)
            usage
            ;;
    esac
done

log "Generating a password"

PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})

if [[ ${USE_SPECIAL_CHARACTER} == "true" ]]
then
    log "Selecting special character"
    SPECIAL_CHARACTER=$(echo '!@#$%^&*()-+=' | fold -w1 | shuf | head -c1)
    PASSWORD=${PASSWORD}${SPECIAL_CHARACTER}
fi

log "Done"
echo "${PASSWORD}"
# GET OPTIND
echo "OPTIND: ${OPTIND}"

# Shift arguments
shift "$(( OPTIND -  1))"
echo "OPTIND: ${OPTIND}"



# numeric arguments
# note that no $A and $B are needed, the variables are expanded in (( ))
A="3"
B="6"
TOTAL=$(( A + B ))
echo $TOTAL

NUM="1"
echo $(( ++NUM ))

# use let or exp
let NUM=2
echo $(( ++NUM ))

NUM=$(expr 2 + 3)
echo $NUM