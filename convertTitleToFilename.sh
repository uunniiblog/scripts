#!/bin/bash

# Iterate over all mp3 and flac files in the current directory
for file in *.mp3 *.flac; do
    if [ -f "$file" ]; then  # Check if it's a regular file
        filename=$(basename -- "$file")  # Get the filename with extension
        extension="${filename##*.}"  # Get the file extension
        filename_no_ext="${filename%.*}"  # Get the filename without extension

        # Assign the filename without extension as the metadata title
        case "$extension" in
            mp3)
                eyeD3 --encoding=utf8 --title="$filename_no_ext" "$file"
                ;;
            flac)
                # Using metaflac for flac files
                metaflac --remove-tag=TITLE --set-tag=TITLE="$filename_no_ext" "$file"
                ;;
            *)
                echo "Unsupported file format: $file"
                ;;
        esac
        echo "Metadata title set for: $file"
    fi
done

