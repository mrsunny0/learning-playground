#!/bin/bash

# [-l location] [--location location] [-e extension] [--extension extension] [-h] [--help] [-s] [--stats]

# USAGE FUNCTION
function echo_help() {
    echo "USAGE: $0 [-l location] [--location location] [-e extension] [--extension extension] [-h] [--help] [-s] [--stats]"
    echo "Examples: "
    echo -e "\t$0 -l /etc/ -e txt -s"
    echo -e "\t$0 --location /etc/ --extension txt"
    echo -e "\t$0 -e txt --stats"
}

# GET USER INPUT
while [[ "$#" != 0 ]]
do
    case $1 in
        -h|--help)
            echo "help: "
            echo_help
            exit 0
            ;;
        -l|--location)
            if [[ -d "$2" ]]; then
                LOCATION="$2"
            else 
                echo_help
                exit 1
            fi
            shift
            ;;
        -e|--extension)
            EXTENSION="$2"
            shift
            ;;
        -s|--stats)
            STATS=1
            ;;
        -u|--unit)
            case $2 in
                n)
                    DIVIDER=1
                    ;;
                k)
                    DIVIDER=1024
                    ;;
                m)
                    DIVIDER=$(( 1024 * 1024 ))
                    ;;
                *)
                    echo "please pick a unit of n, k, or m"
                    echo_help
                    exit 1
            esac
            shift
            ;;
        *)
            echo "input \"$1\" unknown flag, existing"
            echo_help
            exit 1
            ;;
    esac
    shift
done

# DEFAULT LOCATION
if [[ -z $LOCATION ]]; then
    LOCATION=$(pwd)
fi

# DEFAULT EXTENSION
if [[ -z $EXTENSION ]]; then
    EXTENSION=""
fi

# DEFAULT UNIT
if [[ -z $DIVIDER ]]; then
    DIVIDER=1
fi

# FIND FILES WITH GIVEN EXTENSION
# ls -l $LOCATION | grep -E "^[^d].*${EXTENSION}$" > /dev/null
OUTPUT=$(ls -l $LOCATION | grep -E "^[^d].*${EXTENSION}$")

# CHECK IF ANYFOUND
if [[ $? != 0 ]]; then
    echo "Could not find any files with given extension: \".$EXTENSION\""
    exit 2
fi

# PERFORM FILE COUNT
echo "$OUTPUT" |\
sed "1d" | \
awk -v D="$DIVIDER" -v S="$STATS" '
BEGIN {
    SIZE=0
}
{
    SIZE+=$5
    if (NR==1) {
        SMALL=$5
        LARGE=$5
        SFILE=$NF
        LFILE=$NF
    }
    if ($5 < SMALL) {
        SMALL=$5
        SFILE=$NF
    }
    if ($5 > LARGE) {
        LARGE=$5
        LFILE=$NF
    }
}
END {
    print "total size: " SIZE/D " MB"
    print "number of files " NR
    
    # additional stats
    if (S == 1) {
        print "Smallest file is " "\"" SFILE "\"" " with size of " SMALL/D " MB"
        print "Largest file is " "\"" LFILE "\"" " with size of " LARGE/D " MB"
    }
}
'