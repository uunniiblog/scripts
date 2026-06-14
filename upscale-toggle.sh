#!/usr/bin/env bash

PROCESS_NAME="upscale"
#UPSCALE_MODEL="-m fast"

DEFAULT_PROFILE="--profile 720p"
#DEFAULT_PROFILE="--profile 1080p"
#DEFAULT_PROFILE="--profile 600p"
#DEFAULT_PROFILE="--profile window"

#MONITOR="--monitor HDMI-A-2"

#WINDOW_MODE="--overlay-mode windowed --output-geometry x1440"

SCREENSHOT_DIR="--screenshot-dir ~/Pictures/Screenshots/VNs --screenshot-filename {title}/Screenshot_{timestamp:%Y%m%d_%H%M%S}_{model}.png"

WINDOW_TITLE="$1"
PROFILE_ARG="$2"
CROP_TOP="$3"

LOG_FILE="--log-file $HOME/upscale.log"

if [ -n "$PROFILE_ARG" ]; then
    PROFILE="--profile $PROFILE_ARG"
else
    PROFILE="$DEFAULT_PROFILE"
fi

if [ -n "$CROP_TOP" ]; then
    CROP_CMD="--crop-top $CROP_TOP"
else
    CROP_CMD=""
fi

#--double-upscale
BASE_CMD="mangohud $PROCESS_NAME $PROFILE --debug $LOG_FILE $MONITOR --target-delay 1 $SCREENSHOT_DIR $CROP_CMD"

if [ -n "$WINDOW_TITLE" ]; then
    UPSCALE_CMD="$BASE_CMD -t $WINDOW_TITLE"
    # Wait for game to open
    # sleep 5
else
    UPSCALE_CMD="$BASE_CMD"
fi

echo $UPSCALE_CMD

# Check if process is running by name
if pgrep -x "$PROCESS_NAME" > /dev/null; then
    pkill -x "$PROCESS_NAME"
else
    # Launch detached so it survives the script exiting
    nohup $UPSCALE_CMD > /dev/null 2>&1 &
fi

# profiles:
#   720p:
#     match: {}
#     options:
#       model: 8x32
#       double_upscale: true
#       blur: 0.85
#       antiring_strength: 0.95
#       cas_enabled: true
#       cas_strength: 0.35
#       hide_cursor: 5000
#       max_fps: 60
#       vulkan_present_mode: mailbox
#       tile_context_margin: 20
#   1080p:
#     match: {}
#     options:
#       model: 4x32
#       double_upscale: false
#       blur: 0.85
#       cas_enabled: true
#       cas_strength: 0.3
#       hide_cursor: 5000
#       max_fps: 60
#       vulkan_present_mode: mailbox
#   600p:
#     match: {}
#     options:
#       model: 4x32
#       double_upscale: true
#       blur: 0.85
#       antiring_strength: 0.95
#       cas_enabled: true
#       cas_strength: 0.4
#       hide_cursor: 5000
#       max_fps: 60
#       vulkan_present_mode: mailbox
#       tile_context_margin: 20
#       tile_size: 64
#   window:
#     match: {}
#     options:
#       model: 4x32
#       blur: 0.85
#       cas_enabled: true
#       cas_strength: 0.3
#       output_geometry: x1440
#       overlay_mode: windowed
#       hide_cursor: 5000
#       max_fps: 60
#       vulkan_present_mode: mailbox

