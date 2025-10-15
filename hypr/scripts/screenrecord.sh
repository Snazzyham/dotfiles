#!/usr/bin/env bash

OUTDIR="$HOME/Videos"
mkdir -p "$OUTDIR"

CODEC="--codec libx264"
CRF=28     # Compression quality (lower = better quality, larger file)
PRESET="fast"  # Compression speed/efficiency tradeoff

if pgrep -x "wf-recorder" > /dev/null; then
    # Stop the current recording
    pkill -INT wf-recorder

    # Find the latest file
    latest_file=$(ls -t "$OUTDIR"/recording_*.mp4 | head -n 1)

    # Compress with ffmpeg
    if [[ -f "$latest_file" ]]; then
        compressed_file="${latest_file%.mp4}_compressed.mp4"
        ffmpeg -y -i "$latest_file" -vf "scale=-2:'min(720,ih)'" \
            -c:v libx264 -preset "$PRESET" -crf "$CRF" -c:a aac -b:a 128k \
            "$compressed_file" && mv "$compressed_file" "$latest_file"
    fi

    # Notify user
    if command -v ffprobe &>/dev/null; then
        duration=$(ffprobe -v error -show_entries format=duration \
            -of default=noprint_wrappers=1:nokey=1 "$latest_file")
        duration=$(printf "%.1f" "$duration")
        notify-send "Recording Stopped" "Saved: $(basename "$latest_file")\nDuration: ${duration}s (compressed to 720p)"
    else
        notify-send "Recording Stopped" "Saved: $(basename "$latest_file") (compressed to 720p)"
    fi

else
    choice=$(printf "1. Full Screen\n2. Full Screen + Audio\n3. Region\n4. Region + Audio" | rofi -dmenu -p "Screen Record")
    output="$OUTDIR/recording_$(date +%Y-%m-%d_%H-%M-%S).mp4"

    case $choice in
        "1. Full Screen")
            wf-recorder $CODEC -f "$output" &
            notify-send "Recording Full Screen" "Saving to $output"
            ;;
        "2. Full Screen + Audio")
            wf-recorder $CODEC --audio -f "$output" &
            notify-send "Recording Full Screen + Audio" "Saving to $output"
            ;;
        "3. Region")
            wf-recorder $CODEC -g "$(slurp)" -f "$output" &
            notify-send "Recording Region" "Saving to $output"
            ;;
        "4. Region + Audio")
            wf-recorder $CODEC --audio -g "$(slurp)" -f "$output" &
            notify-send "Recording Region + Audio" "Saving to $output"
            ;;
    esac
fi
