#!/usr/bin/env bash

# Get total and used memory in GB
read -r total used <<< $(free -b | awk '/^Mem:/ {printf "%.2f %.2f", $2/1073741824, $3/1073741824}')

# Get top memory consumers, grouped by base process name
# Groups processes like "zen" (from zen-browser), "Discord", etc.
top_apps=$(ps -eo rss,comm --no-headers | awk '
{
    # Get base name (remove paths, common suffixes)
    name = $2
    gsub(/.*\//, "", name)  # remove path
    gsub(/-bin$/, "", name) # remove -bin suffix
    gsub(/\.exe$/, "", name) # remove .exe

    # Group common apps
    lname = tolower(name)
    if (lname ~ /^zen/) name = "Zen"
    else if (lname ~ /^discord/) name = "Discord"
    else if (lname ~ /^firefox/) name = "Firefox"
    else if (lname ~ /^chrom/) name = "Chrome"
    else if (lname ~ /^code/) name = "VS Code"
    else if (lname ~ /^electron/) name = "Electron"
    else if (lname ~ /^slack/) name = "Slack"
    else if (lname ~ /^spotify/) name = "Spotify"
    else if (lname ~ /^telegram/) name = "Telegram"

    mem[name] += $1
}
END {
    for (name in mem) {
        printf "%.0f %s\n", mem[name], name
    }
}' | sort -rn | head -3 | awk '{printf "%s: %.1f GB\\n", $2, $1/1048576}' | sed 's/\\n$//')

echo "{\"text\": \" $used / $total GB\", \"tooltip\": \"$top_apps\"}"
