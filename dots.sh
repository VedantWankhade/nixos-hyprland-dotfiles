#!/usr/bin/env bash

# Clean up
echo "Cleaning up old configs..."
echo "Cleaning up ~/.config/hypr"
rm -rf ~/.config/hypr
echo "Cleaning up ~/.config/waybar"
rm -rf ~/.config/waybar
if [ -d ~/.local/share/wallpapers ];
then
  echo "~/.local/share/wallpapers exists, cleaning up -\n`ls ./.local/share/wallpapers`"
  for file in ./.local/share/wallpapers/*; do
    if [ -e ~/.local/share/wallpapers/$(basename "$file") ]; then
        rm -r ~/.local/share/wallpapers/$(basename "$file")
    fi
  done
fi
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
