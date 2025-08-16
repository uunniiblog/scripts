#!/bin/bash

# Configuration
OWOCR_DIR="/tmp/owocr"

# Create directory if it doesn't exist
if [ ! -d "$OWOCR_DIR" ]; then
    mkdir -p "$OWOCR_DIR"
    echo "Created directory: $OWOCR_DIR"
fi

# Generate filename with current date and time
FILENAME="$(date +%Y%m%d_%H%M%S).png"
OUTPUT_FILE="$OWOCR_DIR/$FILENAME"

# Take screenshot
# echo "Taking screenshot..."
spectacle --region --background --nonotify --output "$OUTPUT_FILE"

# Check if screenshot was successful
: '
if [ -f "$OUTPUT_FILE" ] && [ -s "$OUTPUT_FILE" ]; then
    echo "✓ Screenshot saved: $FILENAME"
    echo "  Location: $OUTPUT_FILE"
    echo "  Size: $(stat -c%s "$OUTPUT_FILE") bytes"
    
    echo ""
    echo "Start owocr with:"
    echo "  owocr -r \"$OWOCR_DIR\" -w clipboard -e glens -d -n"
else
    echo "✗ Screenshot failed"
    exit 1
fi
'
