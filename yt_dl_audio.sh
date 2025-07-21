#!/bin/bash

# YouTube Audio Downloader Script
# Usage: ytdl <youtube_url>

# Check if URL parameter is provided
if [ $# -eq 0 ]; then
    echo "Usage: ytdl <youtube_url>"
    echo "Example: ytdl https://www.youtube.com/watch?v=QFRXXXXX"
    exit 1
fi

# Get the YouTube URL from the first parameter
URL="$1"

# Run yt-dlp with your preferred settings
yt-dlp -f bestaudio \
    --extract-audio \
    --audio-format opus \
    --audio-quality 0 \
    -o "%(channel)s - %(title)s (%(upload_date)s).%(ext)s" \
    "$URL"
