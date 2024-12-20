#!/usr/bin/bash

# Check if a directory is provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# loop over each file in the directory
for file in "$1"/*; do
    # check if the file is a directory
    if [[ -d $file ]]; then
        echo "$file is a directory"
    else
        echo "$file is a file"
        # create a dir with the same name as the file extension if not created
        ext="${file##*.}"
        if [[ "$file" == *.* ]]; then
            if [[ ! -d "$1/$ext" ]]; then
                mkdir "$1/$ext"
            fi
        else
            if [[ ! -d "$1/no_ext" ]]; then
                mkdir "$1/no_ext"
            fi
        fi
        # move the file to the directory
        if [[ "$file" == *.* ]]; then
            mv "$file" "$1/$ext"
        else
            mv "$file" "$1/no_ext"
        fi
    fi
done