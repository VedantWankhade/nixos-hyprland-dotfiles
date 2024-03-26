#!/usr/bin/env bash

# Function to safely remove existing symlink
remove_symlink() {
    local target=$1
    if [ -L "$target" ]; then
        echo "Removing existing symlink: $target"
        rm "$target"
    elif [ -e "$target" ]; then
        echo "Error: $target exists and is not a symlink. Please remove it manually."
        exit 1
    fi
}

# Clean up
echo "Cleaning up old configs..."
remove_symlink "$HOME/.config/hypr"
remove_symlink "$HOME/.config/waybar"

if [ -d "$HOME/.local/share/wallpapers" ]; then
    echo "Cleaning up ~/.local/share/wallpapers..."
    for file in "$HOME/.local/share/wallpapers/"*; do
        if [ -e "$file" ]; then
            rm -rf "$file"
        fi
    done
fi

# Stow
echo "Stowing..."
stow --no-folding .

# Post stow setup
echo "Running post install hooks"
echo "Cleaning bat cache"
bat cache --build
echo "Installing vscode extensions"
while IFS= read -r line; do
    code --install-extension "$line"
done < "$HOME/.config/Code/extensionids.list.txt"
