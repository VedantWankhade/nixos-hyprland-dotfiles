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

# Function to safely remove existing directory
remove_directory() {
    local target=$1
    if [ -d "$target" ]; then
        echo "Removing existing directory: $target"
        rm -rf "$target"
    fi
}

# Clean up
echo "Cleaning up old configs..."
remove_symlink "$HOME/.config/hypr"
remove_symlink "$HOME/.config/waybar"

if [ -d "$HOME/.local/share/wallpapers" ]; then
    echo "Cleaning up ~/.local/share/wallpapers..."
    remove_directory "$HOME/.local/share/wallpapers"
fi

# Stow
echo "Stowing..."
stow --no-folding .

# Post stow setup
echo "Running post install hooks"
echo "Cleaning bat cache"
bat cache --build

echo "Setting up flathub and installing flatpak apps"
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub io.github.zen_browser.zen
flatpak install -y flathub com.github.tchx84.Flatseal

echo "Installing vscode extensions"
while IFS= read -r line; do
    code --install-extension "$line"
done < "$HOME/.config/Code/extensionids.list.txt"
echo "Installing go tools..."
go install github.com/go-delve/delve/cmd/dlv@latest
go install mvdan.cc/gofumpt@latest
go install golang.org/x/tools/cmd/goimports@latest
