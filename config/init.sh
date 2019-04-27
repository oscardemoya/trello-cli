#!/bin/sh

init() {
    set_username $1
    if [ -z "$BOARD_SHORT_LINK" ]; then
        member_boards $USERNAME
    fi
    set_board_id $2
    show_config
}

set_username() {
    if [ -z "$1" ]; then
        if [ -z "$USERNAME" ]; then
            read -r -p "Enter your trello username: " USERNAME
            USERNAME=${USERNAME}
            if [ -z "$USERNAME" ]; then
                printf $FORMAT_RED "Username is required."
                exit 1
            fi
            set_config USERNAME $USERNAME
        fi
    else
        USERNAME=$1
        set_config USERNAME $USERNAME
    fi
}

set_board_id() {
    if [ -z "$1" ]; then
        if [ -z "$BOARD_SHORT_LINK" ]; then
            read -r -p "Enter your trello board short link: " BOARD_SHORT_LINK
            BOARD_SHORT_LINK=${BOARD_SHORT_LINK}
            if [ -z "$BOARD_SHORT_LINK" ]; then
                printf $FORMAT_RED "Board ID is required."
                exit 1
            fi
            set_config BOARD_SHORT_LINK $BOARD_SHORT_LINK
        fi
    else
        BOARD_SHORT_LINK=$1
        set_config BOARD_SHORT_LINK $BOARD_SHORT_LINK
    fi
}