#!/bin/bash
# data_analysis_csv.sh
# Given a CSV file, shows the most common entry in each column.
#
# Usage: ./data_analysis_csv.sh <file.csv>
# Example: ./data_analysis_csv.sh Students.csv

# Check that we got exactly 1 argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <file.csv>"
    exit 1
fi

file=$1

# Check that the file exists
if [ ! -f "$file" ]; then
    echo "Error: $file does not exist"
    exit 1
fi

# Count the columns by counting the commas in the first line, plus 1
num_cols=$(head -n 1 "$file" | tr ',' '\n' | wc -l)

# Loop over each column number: 1, 2, 3, ...
for i in $(seq 1 $num_cols); do
    # Get the column name from the header (first line)
    name=$(head -n 1 "$file" | cut -d ',' -f $i)

    # tail -n +2  -> skip the header line
    # cut         -> take only column i
    # sort        -> put identical values next to each other
    # uniq -c     -> count each value
    # sort -nr    -> sort by count, biggest first
    # head -n 1   -> keep only the most common one
    top=$(tail -n +2 "$file" | cut -d ',' -f $i | sort | uniq -c | sort -nr | head -n 1)

    echo "Column '$name': most common is $top"
done