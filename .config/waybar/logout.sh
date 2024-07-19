#!/usr/bin/env bash

# Define the menu options
options="No I wanna stay!\nShutdown\nReboot\nHibernate"

# Display the menu and get the user's choice
choice=$(echo -e $options | wofi --dmenu --prompt "Leaving? ")

# Execute the appropriate command based on the user's choice
case "$choice" in
    Shutdown)
        systemctl poweroff
        ;;
    Reboot)
        systemctl reboot
        ;;
    Hibernate)
        systemctl hibernate
        ;;
    *)
        echo "Staying..."
        ;;
esac

