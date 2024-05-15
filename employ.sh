#!/bin/bash

# Check if the input file exists
if [ ! -f "employees.txt" ]; then
    echo "Error: employees.txt not found."
    exit 1
fi

# Extracting names and salaries of employees from the Engineering department, removing commas, and sorting by salary
grep ":Engineering:" employees.txt | \
awk -F ":" '{gsub(",", "", $4); print $2 ":" $4}' | \
sed 's/:/\t/' | \
sed 's/\(.*\)\t\(.*\)/\1: ₹\2/' | \
sort -nr -t$'\t' -k 2
