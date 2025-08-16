#!/bin/bash

# Configuration
OWOCR_DIR="/tmp/owocr"

# Create directory if it doesn't exist
if [ ! -d "$OWOCR_DIR" ]; then
    mkdir -p "$OWOCR_DIR"
    echo "Created directory: $OWOCR_DIR"
fi

# -d deletes image
# -n enables notification

owocr -r "/tmp/owocr" -w clipboard -e glens -d -n
