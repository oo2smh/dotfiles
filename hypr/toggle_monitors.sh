#!/bin/bash
# relies on jq being installed
# allows for toggling between 2 monitors with 1 keybind in

# Get the current active monitor
CURRENT_MONITOR=$(hyprctl activeworkspace -j | jq -r '.monitor')

case "$1" in
    "1")
        if [[ "$CURRENT_MONITOR" == "HDMI-A-1" ]]; then
            hyprctl dispatch focusmonitor "DP-3"
        else
            hyprctl dispatch focusmonitor "HDMI-A-1"
        fi
        ;;

    # Logic for SUPER, 2 (Toggles between DP-1 and DP-3)
    "2")
        if [[ "$CURRENT_MONITOR" == "DP-1" ]]; then
            hyprctl dispatch focusmonitor "DP-3"
        else
            hyprctl dispatch focusmonitor "DP-1"
        fi
        ;;
esac
