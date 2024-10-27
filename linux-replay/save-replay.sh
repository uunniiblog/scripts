#!/bin/sh -e

killall -SIGUSR1 gpu-screen-recorder && sleep 0.5 && notify-send --icon=com.dec05eba.gpu_screen_recorder -u low -- "GPU Screen Recorder" "Replay saved"
