#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Path to the 'add-bin-dir' script, assuming it's in the same directory as this script
ADD_BIN_DIR_SCRIPT="$SCRIPT_DIR/add-bin-dir.sh"

# Call the 'add-bin-dir' script to ensure 'bin' directory is created and in the PATH
/bin/bash "$ADD_BIN_DIR_SCRIPT"

# Define the directory where your 'git-' scripts are located, assuming the current directory
GIT_SCRIPTS_DIR="$SCRIPT_DIR"

# The 'bin' directory path
BIN_DIR="$HOME/bin"

# Check if the --dry flag is set
DRY_RUN=false
if [ "$1" == "--dry" ]; then
  DRY_RUN=true
fi

# Function to create symlinks or simulate creating them
create_symlink() {
    local script=$1
    local symlink_path="$BIN_DIR/$(basename "$script")"
    if [ -x "$script" ]; then  # Check if the script file is executable
        if $DRY_RUN; then
            echo "Dry run: Would create symlink for $(basename "$script")"
        else
            ln -s "$script" "$symlink_path"
            echo "Symlink created for $(basename "$script")"
        fi
    else
        echo "Skipped $(basename "$script") as it is not executable."
    fi
}

# Now create symlinks for all 'git-' scripts in the 'bin' directory
for script in "$GIT_SCRIPTS_DIR"/git-*; do
    if [[ -f "$script" ]]; then
        create_symlink "$script"
    fi
done

# Let the user know the operation is complete
if $DRY_RUN; then
    echo "Dry run complete. No symlinks were actually created."
else
    echo "All executable Git scripts have been symlinked to $BIN_DIR."
fi
