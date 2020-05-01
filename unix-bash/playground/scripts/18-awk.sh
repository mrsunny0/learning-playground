#!/bin/bash

awk -F '::' '{print $3, $1, $NF}' data.csv
awk -F ':' '{print $NF}' /etc/passwd

netstat -n -nutl

# number of rows
awk '{print FILENAME, NR;}' text.csv text.csv
awk '{print FILENAME, FNR;}' text.csv text.csv

# number of rows and fields
awk -F '^' '{print NR,"->",NF}' text.csv
