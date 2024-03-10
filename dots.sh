#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Hyprland
echo "Setting up hyprland dots..."
rm -rf ~/.config/hypr
cp -r ./hypr ~/.config/
echo "${GREEN}Done${NC}" 

# Waybar
echo "Setting up waybar dots..."
rm -rf ~/.config/waybar
cp -r ./waybar ~/.config/
echo "${GREEN}Done${NC}"

# Wallpaper
echo "Setting up wallpapers..."
cp ./wallpapers/* ~/Pictures/Wallpapers/
echo "${GREEN}Done${NC}"

