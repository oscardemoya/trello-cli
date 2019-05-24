#!/bin/sh
# requires jq: `brew install jq`

LOCAL_FOLDER="/usr/local"
INSTALLATION_FOLDER="$LOCAL_FOLDER/trello"

source "$INSTALLATION_FOLDER/utils/colors.sh"
source "$INSTALLATION_FOLDER/utils/print-table.sh"
source "$INSTALLATION_FOLDER/utils/keychain.sh"
source "$INSTALLATION_FOLDER/config/init.sh"
source "$INSTALLATION_FOLDER/config/config.sh"
source "$INSTALLATION_FOLDER/config/select-board.sh"
source "$INSTALLATION_FOLDER/docs/help.sh"
source "$INSTALLATION_FOLDER/api/auth.sh"
source "$INSTALLATION_FOLDER/api/member-boards.sh"
source "$INSTALLATION_FOLDER/api/board-lists.sh"
source "$INSTALLATION_FOLDER/api/list-cards.sh"
source "$INSTALLATION_FOLDER/api/card.sh"
source "$INSTALLATION_FOLDER/api/move-card.sh"
source "$INSTALLATION_FOLDER/api/todo.sh"
source "$INSTALLATION_FOLDER/api/doing.sh"

COMMAND=$1
PARAM_1=$2
PARAM_2=$3

if [ "$COMMAND" == 'help' ]; then
    show_help "$PARAM_2"
elif [ "$COMMAND" == 'info' ]; then
    show_config
elif [ "$COMMAND" == 'reset' ]; then
    remove_config_file
else
    requires_app_keys
    load_config
    if [ "$COMMAND" == 'init' ]; then
        init "$PARAM_1" "$PARAM_2"
    elif [ "$COMMAND" == 'boards' ]; then
        member_boards "$PARAM_1" "$PARAM_2"
    elif [ "$COMMAND" == 'select_board' ]; then
        select_board "$PARAM_1"
    elif [ "$COMMAND" == 'select_board_id' ]; then
        select_board_id "$PARAM_1"
    elif [ "$COMMAND" == 'lists' ]; then
        board_lists "$PARAM_1"
    elif [ "$COMMAND" == 'cards' ]; then
        list_cards "$PARAM_1"
    elif [ "$COMMAND" == 'card' ]; then
        card "$PARAM_1"
    elif [ "$COMMAND" == 'card_id' ]; then
        card_id "$PARAM_1"
    elif [ "$COMMAND" == 'todo' ]; then
        todo "$PARAM_1" "$PARAM_2"
    elif [ "$COMMAND" == 'move_to' ]; then
        move_card "$PARAM_1" "$PARAM_2"
    elif [ "$COMMAND" == 'doing' ]; then
        doing_card "$PARAM_1"
    elif [ -z "$COMMAND" ]; then
        member_boards
    else
        printf $FORMAT_RED "Command '$COMMAND' not found."
    fi
fi
