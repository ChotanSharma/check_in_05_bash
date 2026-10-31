#!/bin/bash
# filter_files.sh
# Loops over the file names given as arguments and prints the
# names of the files that have more than 10 lines.
#
# Usage: ./filter_files.sh <file1> <file2> ...
# Example: ./filter_files.sh notes.txt data.csv log.txt

# Check that at least one file name was given
if [ $# -eq 0 ]; then
    echo "Usage: $0 <file1> <file2> ..."
    exit 1
fi

# "$@" means "all the arguments", so this loops over each file name
for file in "$@"; do
    # Skip files that do not exist
    if [ ! -f "$file" ]; then
        echo "$file does not exist, skipping"
        continue
    fi

    # wc -l counts the lines; "<" makes it print only the number
    lines=$(wc -l < "$file")

    # Our criteria: more than 10 lines
    if [ "$lines" -gt 10 ]; then
        echo "$file ($lines lines)"
    fi
done