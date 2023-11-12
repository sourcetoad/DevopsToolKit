#!/bin/bash

# Define the bin directory path
BIN_DIR="$HOME/bin"

# Create the bin directory if it doesn't exist
if [ ! -d "$BIN_DIR" ]; then
    mkdir -p "$BIN_DIR"
    echo "Created $BIN_DIR"
else
    echo "$BIN_DIR already exists."
fi

# add bin to the PATH only if it's not already there
update_path() {
    local profile=$1
    if ! grep -q "PATH=.*:$BIN_DIR" "$profile" && ! grep -q "PATH=$BIN_DIR:.*" "$profile"; then
        echo "export PATH=\"\$PATH:$BIN_DIR\"" >> "$profile"
        echo "Added $BIN_DIR to PATH in $profile"
    else
        echo "$BIN_DIR is already in the PATH in $profile"
    fi
}

# Check for zsh or bash and their respective files
if [ -n "$ZSH_VERSION" ]; then
    if [ -f "$HOME/.zshrc" ]; then
        update_path "$HOME/.zshrc"
    fi
elif [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bash_profile" ]; then
        update_path "$HOME/.bash_profile"
    elif [ -f "$HOME/.bashrc" ]; then
        update_path "$HOME/.bashrc"
    elif [ -f "$HOME/.profile" ]; then
        update_path "$HOME/.profile"
    fi
else
    echo "Unrecognized shell or profile file not found."
fi

# Apply the changes by sourcing the profile files
if [ -n "$ZSH_VERSION" ] && [ -f "$HOME/.zshrc" ]; then
    source "$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bash_profile" ]; then
        source "$HOME/.bash_profile"
    elif [ -f "$HOME/.bashrc" ]; then
        source "$HOME/.bashrc"
    elif [ -f "$HOME/.profile" ]; then
        source "$HOME/.profile"
    fi
fi
