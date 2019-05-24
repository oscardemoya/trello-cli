#!/bin/sh

todo() {
    TODO_COMMAND=$1
    TODO_CARD_TITLE=$2
    if [ "$TODO_COMMAND" == 'pop' ]; then
        first_card "To Do"
    elif [ "$TODO_COMMAND" == 'push' ]; then
        first_card "To Do"
    elif [ -z "$TODO_COMMAND" ]; then
        list_cards "To Do"
    else
        printf $FORMAT_RED "Invalid parameter '$TODO_COMMAND' for 'todo'."
    fi
}
