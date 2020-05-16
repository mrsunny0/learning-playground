#!/bin/bash
# https://www.howtogeek.com/109369/how-to-quickly-resize-convert-modify-images-from-the-linux-terminal/

function usage() {
    echo "resize images by an equal scale factor"
    echo "$@: [-d | --directory] input directory [-o | --output] output directory [-f | --factor] scaling factor, default is 50%"
}

[[ $# == 0 ]] && echo "please provide arguments" && usage

while [[ $# > 0 ]]
do
    case $1 in
        -d|--directory)
            ${2:?"input directory not supplied"}
            shift
            ;;
        -o|--output)
            ${2:?"output directory not supplied"}
            shift
            ;;
        -f|--factor)
            FACTOR=${2:-50}
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            usage
            exit 1
            ;;
    esac
    shift
done

IMAGEDIR="src/img/raw"