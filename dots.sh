#!/usr/bin/env bash

# Clean up
echo "Cleaning up old configs..."
echo "Cleaning up ~/.config/hypr"
rm -rf ~/.config/hypr
echo "Cleaning up ~/.config/waybar"
rm -rf ~/.config/waybar
echo "`ls ./Pictures/Wallpapers`"
for file in ./Pictures/Wallpapers/*; do
    if [ -e ~/Pictures/Wallpapers/$(basename "$file") ]; then
        rm -rf ~/Pictures/Wallpapers/$(basename "$file")
    fi
done
echo "Cleaning up old cursor themes..."
if [ -d ~/.icons ]; 
then
  echo "~/.icons exists..."
  for file in .icons/*; do
     if [ -e ~/.icons/$(basename "$file") ]; then
       rm -rf ~/.icons/$(basename "$file")
     fi
  done
fi

# Stow
echo "Stowing..."
stow .
