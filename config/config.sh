#!/bin/sh

CONFIG_FOLDER=".trello"
CONFIG_FILE="$CONFIG_FOLDER/config.cfg"
CONFIG_DEFAULTS="$INSTALLATION_FOLDER/config/config.cfg.defaults"

load_config() {
    if [ ! -e "${CONFIG_FILE}" ]; then
        # Set default variable values
        mkdir $CONFIG_FOLDER
        touch $CONFIG_FILE
        cp $CONFIG_DEFAULTS $CONFIG_FILE
    fi
    source $CONFIG_FILE
}

show_config() {
    load_config
    printf $FORMAT_WHITE "Default config:"
    CSV="KEY,VALUE\n"
    if [ ! -z "$API_KEY" ]; then
        HIDDEN_API_KEY="**********"
    fi
    CSV+="API_KEY,$HIDDEN_API_KEY\n"
    if [ ! -z "$API_TOKEN" ]; then
        HIDDEN_API_TOKEN="**********"
    fi  
    CSV+="API_TOKEN,$HIDDEN_API_TOKEN\n"  
    CSV+="USERNAME,$USERNAME\n"
    CSV+="BOARD_SHORT_LINK,$BOARD_SHORT_LINK\n"
    printTable ',' $CSV
}

get_config() {
    VALUE="$(read_config_file $CONFIG_FILE "${1}")";
    if [ "${VALUE}" = "" ]; then
        VALUE="$(read_config_file $CONFIG_FILE.defaults "${1}")";
    fi
    printf -- "%s" "${VALUE}";
}

set_config() {
    sed -i '' "s/^\($1\s*=\s*\).*\$/\1$2/" $CONFIG_FILE
}

require_config() {
    require_username
    require_board_id
}

require_username() {
    if [ -z "$USERNAME" ]; then
        printf $FORMAT_RED "Username is required. Please run 'trello init' to configure."
        exit 1
    fi
}

require_board_id() {
    if [ -z "$BOARD_SHORT_LINK" ]; then
        printf $FORMAT_RED "Board ID is required. Please run 'trello init' to configure."
        exit 1
    fi
}

read_config_file() {
    (grep -E "^${2}=" -m 1 "${1}" 2>/dev/null || echo "VAR=") | head -n 1 | cut -d '=' -f 2-;
}

remove_config_file() {
    read -r -p "⚠️  Do you want to remove your trello app keys from the keychain? [y/N]: " DELETE_KEYS
    DELETE_KEYS=${DELETE_KEYS:-n}
	if [[ $DELETE_KEYS =~ ^([yY][eE][sS]|[yY])$ ]]; then
		echo "Deleting trello app keys..."
        delete_password "trello-api-key"
        delete_password "trello-api-token"
        printf $FORMAT_GREEN "🗑  Trello app keys removed."
    else
        printf $FORMAT_GREEN "🔑  Skipped removing Trello app keys."
	fi
    echo "Removing trello config files..."
    rm -rf $CONFIG_FOLDER
    printf $FORMAT_GREEN "Trello config files removed."
}
