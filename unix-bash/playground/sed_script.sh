#!/bin/bash

# ./spaces.sh [file-path] [-f | --fix] [-h | --help]

function usage() {
    echo "Use of $0 [file-path] [-f | --fix] [-h | --help] [-b | --backup extension]"
}

# CHECK INPUT ARGS
if [[ $# == 0 ]]
then
    echo "You did not supply an input file"
    usage
    exit 1
fi

if [[ -f $1 ]]
then
    FILEPATH=$1
    shift
else
    echo "file \"$1\" does not exist"
    exit 1
fi

while [[ $# != 0 ]]
do 
    case $1 in 
        -f|--fix)
            FIX=1
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        -b|--backup)
            if [[ -z $2 ]]; then
                echo "need to provide an extension"
                usage
                exit 1
            fi
            EXTENSION=$2
            IFLAG="-i.$EXTENSION"
            shift
            ;;
        *)
            usage
            exit 1
            ;;
    esac
    shift
done

# REMOVE TABS AND SPACES
if [[ $FIX == 1 ]]
then
    sed $IFLAG -E \
        -e 's/^[[:blank:]]+//g' \
        -e 's/[[:blank:]]+$//g' \
        -e '/^$/d' \
        $FILEPATH

    # \e[0m strips all text attributes
    echo
    echo -e "\e[42m\e[90mDONE\e[0m"
    echo

# SHOW LINES WITH SPACES
else 
    LINENUMBER=0
    while IFS= read -r LINE 
    do
        # print whole line
        let LINENUMBER++ 
        echo "$LINE" | sed -E -e '/^[[:blank:]]+/q9' -e '/[[:blank:]]+$/q7' -e '/^$/q5' > /dev/null
        if [[ $? == 0 ]]; then
            # echo -e "$LINENUMBER\t $line"
            printf %4s "$LINENUMBER: " 
            echo -e "$LINE"
            continue
        fi

        # highlight issue
        printf %4s "$LINENUMBER: " 
        if [[ $LINE =~ ^[[:blank:]]+ ]]; then
            MATCH=$(echo "$BASH_REMATCH" | sed 's/\t/|__TAB__|/g') # if its a tab, print differently
            echo -e -n "\e[41m$MATCH\e[49m"
        fi

        echo -e -n $LINE | sed -E -e 's/^[[:blank:]]+//' -e 's/^[[:blank:]]+$//' 

        # highlight end of line
        if [[ $LINE =~ [[:blank:]]+$ ]]; then
            MATCH=$(echo "$BASH_REMATCH" | sed 's/\t/__TAB__/g')
            echo -e "\e[41m$MATCH\e[49m"
        else 
            echo
        fi
    done < "$FILEPATH"
fi