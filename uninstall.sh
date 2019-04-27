#!/bin/sh
CURRENT_DIR="$(dirname "$0")"
source "$CURRENT_DIR/config/constants.sh"
source "$CURRENT_DIR/utils/colors.sh"

# Copy all files to /usr/local/trello directory
printf $FORMAT_WHITE "Removing trello-cli files..."
if [ -d "$INSTALLATION_FOLDER" ]; then
    echo "Removing installation folder..."
    sudo rm -Rf $INSTALLATION_FOLDER
fi
if [ -L "$SYMLINK" ]; then
    echo "Removing 'trello' symbolic link..."
    unlink $SYMLINK
fi
printf $FORMAT_GREEN "trello uninstalled."
