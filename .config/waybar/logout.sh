#!/usr/bin/env bash

options=("Shutdown" "Reboot" "Hibernate")

choice=$(printf "%s\n" "${options[@]}" | fzf)
echo $choice

case $choice in
    "Shutdown")
        echo "Shutting down now..."
        sleep 4
        sudo shutdown now
        ;;
    "Reboot")
        echo "Rebooting now..."
        sleep 4
        sudo reboot
        ;;
    "Hibernate")
        echo "Hibernating now zzz"
        sleep 4
        sudo systemctl hibernate
        ;;
    *)
        echo "Invalid option selected"
        ;;
esac

