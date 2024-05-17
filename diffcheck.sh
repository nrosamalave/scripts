#!/bin/bash

# Get the names of the two files to compare
read -p "Enter the first file: " file1
read -p "Enter the second file: " file2

# Check if the files exist
if [[ ! -f "$file1" ]] || [[ ! -f "$file2" ]]; then
  echo "Error: One or both files do not exist."
  exit 1
fi

# Run the diff command and display the results
diff "$file1" "$file2"