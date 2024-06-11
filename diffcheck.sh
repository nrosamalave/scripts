#!/bin/bash

# Prompt the user for the first file name
echo "Enter the path to the first domain file:"
read file1

# Check if the file exists
if [ ! -f "$file1" ]; then
  echo "File $file1 does not exist. Exiting."
  exit 1
fi

# Prompt the user for the second file name
echo "Enter the path to the second domain file:"
read file2

# Check if the file exists
if [ ! -f "$file2" ]; then
  echo "File $file2 does not exist. Exiting."
  exit 1
fi

# Sort the files to ensure accurate comparison
sorted_file1=$(mktemp)
sorted_file2=$(mktemp)

sort "$file1" > "$sorted_file1"
sort "$file2" > "$sorted_file2"

# Use comm to find differences
# -1: Suppress lines unique to file1
# -2: Suppress lines unique to file2
# -3: Suppress lines common to both files

echo "Enter the name for the file to store domains only in $file1:"
read file1_only_name
echo "Enter the name for the file to store domains only in $file2:"
read file2_only_name
echo "Enter the name for the file to store domains in both $file1 and $file2:"
read both_files_name

comm -23 "$sorted_file1" "$sorted_file2" > "$file1_only_name.txt"
comm -13 "$sorted_file1" "$sorted_file2" > "$file2_only_name.txt"
comm -12 "$sorted_file1" "$sorted_file2" > "$both_files_name.txt"

echo "Differences have been saved in $file1_only_name.txt, $file2_only_name.txt, and $both_files_name.txt."

# Clean up temporary files
rm "$sorted_file1" "$sorted_file2"
