#!/usr/bin/env bash

# Clean up
echo "Cleaning up old configs..."
echo "Cleaning up ~/.config/hypr"
rm -rf ~/.config/hypr
echo "Cleaning up ~/.config/waybar"
rm -rf ~/.config/waybar
echo "Cleaning up ~/Pictures/Wallpapers/`ls ./Pictures/Wallpapers`"
rm -rf ~/Pictures/Wallpapers/`ls ./Pictures/Wallpapers`

# Stow
echo "Stowing..."
stow .
