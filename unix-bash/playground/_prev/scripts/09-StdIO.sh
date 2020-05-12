#!/bin/bash

FILE="/course/course-projects/TMP.txt"
if [[ -f ${FILE} ]]
then
    # Redirect STDOUT
    head -n1 /etc/passwd > ${FILE} 
    
    # Redirect to STDIN
    read LINE < ${FILE}
    echo
    echo "${LINE}"
    echo

    # continue to append files
    echo "${RANDOM}" >> ${FILE}
    echo "${RANDOM}" >> ${FILE}
    echo "${RANDOM}" >> ${FILE}

else
    echo
    echo "file \"${FILE}\" does not exists"
    echo
    exit 1
fi

[[ -f ${FILE} ]] && cat ${FILE}
echo