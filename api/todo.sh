#!/bin/sh

todo() {
    TODO_COMMAND=$1
    TODO_CARD_TITLE=$2
    if [ "$TODO_COMMAND" == 'start' ]; then
        first_card "To Do"
    elif [ "$TODO_COMMAND" == 'add' ]; then
        
    elif [ -z "$TODO_COMMAND" ]; then
        list_cards "To Do"
    else
        printf $FORMAT_RED "Invalid parameter '$TODO_COMMAND' for 'todo'."
    fi
}
