#!/bin/sh

sleep 5s
pidof -q gpu-screen-recorder && exit 1
video_path="$HOME/Videos/Replays"
replay_length_s=180 # replay length in seconds (300sec=5min)
mkdir -p "$video_path"
#gpu-screen-recorder -w screen -f 60 -a "`pactl get-default-source`|`pactl get-default-sink`.monitor" -c mp4 -r $replay_length_s -o "$video_path" &
primary_screen=$(randr | awk '/ primary / {print $1}')
gpu-screen-recorder -w "DP-1" -f 60 -a alsa_output.pci-0000_09_00.4.analog-stereo.monitor -c mp4 -r $replay_length_s -o "$video_path" &

sleep 1s
if pidof gpu-screen-recorder >/dev/null
then
    qdbus org.kde.kglobalaccel /component/plasmashell invokeShortcut "toggle do not disturb" # Toggle "do not disturb" mode so that it's back on because screencasting automatically turns it off
    notify-send --icon=com.dec05eba.gpu_screen_recorder -- "GPU Screen Recorder" "Replay started"
#   zenity --info --text="Replay started successfully" --icon="com.dec05eba.gpu_screen_recorder"
else
    zenity --warning --text="Replay failed to start" --icon="com.dec05eba.gpu_screen_recorder"
fi
