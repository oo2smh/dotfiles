#!/bin/bash
# relies on jq being installed
# allows for toggling between 2 monitors with 1 keybind in

# Get the current active monitor
current_monitor=$(hyprctl activeworkspace -j | jq -r '.monitor')

# Toggle between HDMI-A-1 and DP-3
if [[ "$current_monitor" == "HDMI-A-1" ]]; then
    hyprctl dispatch focusmonitor "DP-3"
else
    hyprctl dispatch focusmonitor "HDMI-A-1"
fi
