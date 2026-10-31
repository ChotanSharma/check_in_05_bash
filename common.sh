#!/bin/bash
# common.sh
# Lists all files in the current directory that have at least
# N lines containing a given string.
#
# Usage: ./common.sh <string> <number>
# Example: ./common.sh error 2

# Check that we got exactly 2 arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <string> <number>"
    exit 1
fi

word=$1      # the string to search for
min=$2       # the minimum number of matching lines

# Check that the second argument is a whole number (only digits 0-9)
if ! [[ "$min" =~ ^[0-9]+$ ]]; then
    echo "Error: '$min' is not a number"
    exit 1
fi

# Loop over every item in the current directory
for file in *; do
    # Skip anything that is not a regular file (like folders)
    if [ -f "$file" ]; then
        # grep -c counts how many lines contain the word
        count=$(grep -c "$word" "$file")

        # Print the file name if the count is big enough
        if [ "$count" -ge "$min" ]; then
            echo "$file has $count lines containing '$word'"
        fi
    fi
done