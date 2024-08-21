#!/usr/bin/env bash

# Define the menu options
options="Keep it the same!\nPerformance\nBalanced\nPowerSaver"

# Display the menu and get the user's choice
choice=$(echo -e $options | wofi --dmenu --prompt "Set power profile ")

# Execute the appropriate command based on the user's choice
case "$choice" in
    Performance)
        powerprofilesctl set performance
        ;;
    Balanced)
        powerprofilesctl set balanced
        ;;
    PowerSaver)
        powerprofilesctl set power-saver
        ;;
    *)
        echo "Not changing anything..."
        ;;
esac

