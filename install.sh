#!/bin/sh
CURRENT_DIR="$(dirname "$0")"
source "$CURRENT_DIR/config/constants.sh"
source "$CURRENT_DIR/utils/colors.sh"

# Copy all files to /usr/local/trello directory
printf $FORMAT_WHITE "Copying trello files..."
echo "Creating installation folder..."
sudo mkdir $INSTALLATION_FOLDER
chmod -R u+x *.sh
echo "Copying files to installation folder..."
sudo cp -Rp * $INSTALLATION_FOLDER
echo "Creating 'trello' symlink..."
ln -s $INSTALLATION_FOLDER/main.sh $SYMLINK

echo "Checking for dependencies..."
# Check to see if Homebrew is installed, and install it if it is not
command -v brew >/dev/null 2>&1 || { echo >&2 "Installing homebrew..."; \
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; }

if brew ls --versions jq > /dev/null; then
    printf $FORMAT_YELLOW "jq formula is already installed."
else
    echo "Installing jq..."
    brew install jq
fi

printf $FORMAT_GREEN "trello cli-installed. Run 'trello help' for more information."