#!/bin/bash
mkdir ./mp4
for var in *.flac
do
echo $var
ffmpeg -loop 1 -r 1 -i cover.jpg -i "$var" -c:a copy -strict -2 -shortest -c:v libx264 -vf scale=1920:1080 "./mp4/$var.mp4"
done
