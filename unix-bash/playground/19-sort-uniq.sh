#!/bin/bash

# sort 
sort /etc/passwd

# reverse sort
sort -r /etc/passwd

# sort based on number (rather than numbers as strings)
sort -n text.csv
awk -F '^' '{print ($NF - 1)}' text.csv | sort -n

clear

# use sort and awk on ls
ls -al | awk '{print $8}' | sort -n

clear

# use the du command
du -h /etc | sort -nu

# sort and uniq
du -h / | sort -n | uniq -c

# sorting, getting unique, and sorting the number of occurances
clear
du -h / | awk '{print $1}' | sort -n | uniq -c | sort -n
