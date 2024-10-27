#!/bin/bash
mkdir ./flac
for i in *.wav
do 
ffmpeg -i "$i" "./flac/${i%.*}.flac"
done

