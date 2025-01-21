
#!/usr/bin/env bash

# Docker icon from Font Awesome / Nerd Font
icon=""

# Count how many containers are running
container_count=$(docker ps -q | wc -l)

# Get a list of container names (one per line)
container_names=$(docker ps --format "{{.Names}}")

# If you want more details, you could use:
# container_names=$(docker ps --format "{{.Names}} ({{.Image}})")

# If no containers are running, show a specific tooltip
if [ "$container_count" -eq 0 ]; then
  echo "{\"text\": \"$icon 0\", \"tooltip\": \"No containers running\"}"
else
  # Join all container names with newlines in the tooltip
  echo "{\"text\": \"$icon $container_count\", \"tooltip\": \"$container_names\"}"
fi
