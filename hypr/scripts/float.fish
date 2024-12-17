#!/usr/bin/env fish

while true
    set workspaces (hyprctl workspaces -j | jq -r '.[] | .id')
    for workspace in $workspaces
        set window_count (hyprctl clients -j | jq "[.[] | select(.workspace == $workspace)] | length")
        if test "$window_count" -eq 1
            set window_address (hyprctl clients -j | jq -r ".[] | select(.workspace == $workspace) | .address")
            hyprctl dispatch togglefloating $window_address
        else
            set window_addresses (hyprctl clients -j | jq -r ".[] | select(.workspace == $workspace) | .address")
            for address in $window_addresses
                hyprctl dispatch togglefloating $address
            end
        end
    end
    sleep 0.5
end
