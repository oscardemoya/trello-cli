#!/bin/sh
# requires jq: `brew install jq`

CURRENT_DIR="$(dirname "$0")"
source "$CURRENT_DIR/utils/colors.sh"
source "$CURRENT_DIR/utils/print-table.sh"
source "$CURRENT_DIR/utils/keychain.sh"
source "$CURRENT_DIR/config/init.sh"
source "$CURRENT_DIR/config/config.sh"
source "$CURRENT_DIR/config/select-board.sh"
source "$CURRENT_DIR/docs/help.sh"
source "$CURRENT_DIR/api/auth.sh"
source "$CURRENT_DIR/api/member-boards.sh"
source "$CURRENT_DIR/api/board-lists.sh"
source "$CURRENT_DIR/api/list-cards.sh"
source "$CURRENT_DIR/api/card.sh"
source "$CURRENT_DIR/api/move-card.sh"

COMMAND=$1
PARAM_1=$2
PARAM_2=$3

load_config
load_api_keys

if [ "$COMMAND" == 'help' ]; then
    show_help "$PARAM_2"
elif [ "$COMMAND" == 'init' ]; then
    init "$PARAM_1" "$PARAM_2"
elif [ "$COMMAND" == 'config' ]; then
    show_config
elif [ "$COMMAND" == 'remove' ]; then
    remove_config_file
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
    list_cards "To Do"
elif [ "$COMMAND" == 'doing' ]; then
    list_cards "Doing"
elif [ "$COMMAND" == 'move_to' ]; then
    move_card "$PARAM_1" "$PARAM_2"
elif [ -z "$COMMAND" ]; then
    member_boards
else
    printf $FORMAT_RED "Command '$COMMAND' not found."
fi
