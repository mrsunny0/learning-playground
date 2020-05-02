#!/bin/bash

# functions
function usage() {
    verbose "This is how you use this"
    exit 1
}

VERBOSE=false
function verbose() {
    if [[ $VERBOSE == true ]]
    then 
        echo $1
    fi
}

# default option arguments
COLUMNS=3
FILENAME="data.csv"
OVERWRITE=false
DELIMITER=$(echo '!@#$%^&*()-+=' | fold -w1 | shuf | head -c1)

# get options
while getopts "vof:c:d:" OPTION; do
    case $OPTION in 
        v) VERBOSE=true; verbose "VERBOSE ON" ;;
        c) COLUMNS=$OPTARG ;;
        f) FILENAME=$OPTARG ;;
        o) OVERWRITE=true ;;
        d) DELIMITER=$OPTARG ;;
        \?) echo "Invalid option" >&2 ;;
    esac
done
shift $(( OPTIND - 1 ))

# create filename, check if it exists
if [[ -f $FILENAME ]]
then
    if [[ $OVERWRITE == false ]]
    then
        echo
        echo "File name exists"
        exit 1
    else
        echo
        echo "Overwriting file"
        echo "" > $FILENAME
    fi
# create filename if it does not exists
else
    verbose "Creating filename: $FILENAME"
    touch $FILENAME
fi

# check if operation succeeded
if [[ $? > 0 ]]
then
    echo "Operation failed" >&2
    exit 1
fi

# create header file
NUMBER_OF_LINES=${1:-10}
HEADER=$(eval echo "header{1..$COLUMNS}${DELIMITER}")
HEADER=${HEADER%*${DELIMITER}}
HEADER=$(echo $HEADER | sed "s/\s//g")
echo $HEADER > $FILENAME

# loop and create body of file
LINE=""
for (( i=1; i<=$NUMBER_OF_LINES; i++ ))
do 
    LINE=""
    for (( j=1; j<=$COLUMNS; j++ ))
    do
        INFO=$(echo $RANDOM | head -c4)
        LINE+=${INFO}${DELIMITER}
    done
    # remove last delimiter
    LINE=${LINE%${DELIMITER}}

    # add to current file
    echo $LINE >> $FILENAME
done

# print out if verbose
if [[ $VERBOSE ]]; then
    cat $FILENAME
fi