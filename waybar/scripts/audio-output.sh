#!/usr/bin/env bash

# Get all available sinks
mapfile -t sinks < <(pactl list sinks short | awk '{print $2}')

if [[ ${#sinks[@]} -eq 0 ]]; then
    echo '{"text": "no sinks", "tooltip": "No audio outputs found"}'
    exit 0
fi

current=$(pactl get-default-sink)

# Get friendly name for a sink
sink_label() {
    local name="$1"
    pactl list sinks | awk -v name="$name" '
        /^\tName:/ { found = ($2 == name) }
        found && /^\tDescription:/ {
            sub(/^\tDescription: /, "")
            print
            exit
        }
    '
}

if [[ "$1" == "--toggle" ]]; then
    # Find index of current sink
    current_idx=-1
    for i in "${!sinks[@]}"; do
        if [[ "${sinks[$i]}" == "$current" ]]; then
            current_idx=$i
            break
        fi
    done

    # Move to next sink (wrapping)
    next_idx=$(( (current_idx + 1) % ${#sinks[@]} ))
    next_sink="${sinks[$next_idx]}"

    pactl set-default-sink "$next_sink"

    # Move all active sink inputs to the new default
    pactl list sink-inputs short | awk '{print $1}' | while read -r input; do
        pactl move-sink-input "$input" "$next_sink"
    done
else
    # Output JSON for waybar
    label=$(sink_label "$current")
    tooltip=""
    for sink in "${sinks[@]}"; do
        desc=$(sink_label "$sink")
        if [[ "$sink" == "$current" ]]; then
            tooltip+="▶ $desc\n"
        else
            tooltip+="  $desc\n"
        fi
    done

    # Shorten label for display
    short_label=$(echo "$label" | sed 's/ Analog Stereo//' | sed 's/ Audio Controller//')

    printf '{"text": " %s", "tooltip": "%s"}\n' "$short_label" "${tooltip%\\n}"
fi
