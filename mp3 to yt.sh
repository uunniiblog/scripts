#!/bin/bash
mkdir ./mp4
for var in *.mp3
do
    echo $var
    # Get filename without extension for output
    basename=$(basename "$var" .mp3)
    ffmpeg -loop 1 -r 1 -i cover.jpg -i "$var" -c:a copy -strict -2 -shortest -c:v libx264 -crf 18 -preset slow -vf scale=1920:1080 "./mp4/$basename.mp4"
done
