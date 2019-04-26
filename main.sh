#!/bin/sh
# requires jq: `brew install jq`

CURRENT_DIR="$(dirname "$0")"
source "$CURRENT_DIR/config.sh"
source "$CURRENT_DIR/colors.sh"
source "$CURRENT_DIR/print-table.sh"
source "$CURRENT_DIR/get-pw.sh"
source "$CURRENT_DIR/member-boards.sh"
source "$CURRENT_DIR/board-lists.sh"
source "$CURRENT_DIR/select-board.sh"
source "$CURRENT_DIR/list-cards.sh"
source "$CURRENT_DIR/card.sh"
source "$CURRENT_DIR/move-card.sh"

API_KEY="$(get_pw trello-api-key)"
API_TOKEN="$(get_pw trello-api-token)"
BASE_PATH="https://api.trello.com/1"
AUTH_PARAMS="key=$API_KEY&token=$API_TOKEN"

COMMAND=$1
PARAM_1=$2
PARAM_2=$3

load_config

if [ "$COMMAND" == 'boards' ]; then
    member_boards "$PARAM_1"
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
elif [ "$COMMAND" == 'config' ]; then
    show_config
elif [ "$COMMAND" == 'help' ]; then
    cat help.txt
elif [ -z "$COMMAND" ]; then
    member_boards
else
    printf $FORMAT_RED "Command '$COMMAND' not found."
fi
