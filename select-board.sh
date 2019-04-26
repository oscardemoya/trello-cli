#!/bin/sh
# requires jq: `brew install jq`

select_board() {
    SELECTED_BOARD_NAME=$1
    member_boards $USERNAME "$SELECTED_BOARD_NAME"
    if [ -z "$SELECTED_BOARD_SHORT_LINK" ]; then
        set_config BOARD_ID $SELECTED_BOARD_SHORT_LINK
        printf $FORMAT_GREEN "📋 Board '$SELECTED_BOARD_NAME' selected."
    fi
}

select_board_id() {
    SELECTED_BOARD_ID=$1
    if [ -z "$SELECTED_BOARD_ID" ]; then
        set_config BOARD_ID $SELECTED_BOARD_ID
        printf $FORMAT_GREEN "📋 Board [$SELECTED_BOARD_ID] selected."
    fi
}
