#!/bin/sh

FOLDER="$HOME/.trello"
CONFIG="$FOLDER/config.cfg"

load_config() {
    if [ ! -e "${CONFIG}" ]; then
        # Set default variable values
        mkdir $FOLDER
        touch $CONFIG
        echo "USERNAME=\"\"\nBOARD_ID=\"\"\n" >> $CONFIG
    fi
    source $CONFIG
}

show_config() {
    printf $FORMAT_WHITE "Default config:"
    CSV="KEY,VALUE\n"
    CSV+="USERNAME,$USERNAME\n"
    CSV+="BOARD_ID,$BOARD_ID\n"
    printTable ',' $CSV
}

get_config() {
    VALUE="$(read_config_file $CONFIG "${1}")";
    if [ "${VALUE}" = "" ]; then
        VALUE="$(read_config_file $CONFIG.defaults "${1}")";
    fi
    printf -- "%s" "${VALUE}";
}

set_config() {
    sed -i '' "s/^\($1\s*=\s*\).*\$/\1$2/" $CONFIG
}

read_config_file() {
    (grep -E "^${2}=" -m 1 "${1}" 2>/dev/null || echo "VAR=") | head -n 1 | cut -d '=' -f 2-;
}
