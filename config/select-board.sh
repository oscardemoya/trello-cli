#!/bin/sh
# requires jq: `brew install jq`

select_board() {
    SELECTED_BOARD_NAME=$1
    member_boards $USERNAME "$SELECTED_BOARD_NAME"
    if [ ! -z "$SELECTED_BOARD_SHORT_LINK" ]; then
        set_config BOARD_SHORT_LINK $SELECTED_BOARD_SHORT_LINK
        printf $FORMAT_GREEN "📋 Board '$SELECTED_BOARD_NAME' [$SELECTED_BOARD_SHORT_LINK] selected."
    fi
    show_config
}

select_board_id() {
    SELECTED_BOARD_SHORT_LINK=$1
    if [ ! -z "$SELECTED_BOARD_SHORT_LINK" ]; then
        set_config BOARD_SHORT_LINK $SELECTED_BOARD_SHORT_LINK
        printf $FORMAT_GREEN "📋 Board [$SELECTED_BOARD_SHORT_LINK] selected."
    fi
    show_config
}
