#!/bin/bash

# Directory to search
directory="$(pwd)/sigma/"

# Output file
output_file="yml_files.txt"

# Get today's date in the format YYYYmmdd
today_date=$(date +'%Y%m%d_%H%M%S')

# Pulls SigmaHQ from Sigma_HQ
git clone https://github.com/SigmaHQ/sigma.git

# Makes directory for Splunk rules output
mkdir "$today_date-splunk-rules"

# Execute find command and write output to the file
find "$directory" -type f -name "*.yml" > "$output_file"

while IFS= read -r line; do

    # Sets file name output     
    filename_without_extension=$(basename "$line" .yml)
    
    # Sigma cli command creates the Splunk text
    sigma convert --without-pipeline  -t splunk -f default $line > "$(pwd)/$today_date-splunk-rules/$filename_without_extension-splunk_query.txt"

done < "$output_file"