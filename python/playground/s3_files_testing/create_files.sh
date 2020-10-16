#!/bin/bash
for i in 1 2 3 4 5
do
    file_name=file${i}.txt
    echo ${file_name}
    touch ${file_name}
    echo "I am in file ${i}" >> ${file_name}
done
