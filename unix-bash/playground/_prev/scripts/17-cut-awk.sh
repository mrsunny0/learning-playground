#!/bin/bash

# get play data
DATA=$(cat /etc/passwd)
echo $DATA

# cut
echo $DATA | sed "s/\s/\n/g" | cut -c ${1:-1}

# cut range
echo $DATA | sed "s/\s/\n/g" | cut -c ${1:-4-7}

# cut positionally 
echo $DATA | sed "s/\s/\n/g" | cut -c ${1:-1,3,5}

# cutting based on fields
DATA='1\t2\t3'
echo -e $DATA | cut -f 2

# non-tab separated files
DATA='1,2,3,4,5'
echo -e $DATA | cut -d , -f 2

# get play data
DATA=$(cat /etc/passwd)

# transform data with sed
DATA=$(echo -e $DATA | sed "s/\s/\n/g")
echo -e ${DATA@Q}
echo -e ${DATA:Q} | cut -d ':' -f 1,3,5

# # Testing out escape characters
# DATA="\n\n\n\n\n\t\t\t100"
# echo -e ${DATA@Q}

cut -d ':' -f 1,3 /etc/passwd --output-delimiter=","

awk -F '::' -v OFS='\t' '{print $1 "&" $2}' data.csv