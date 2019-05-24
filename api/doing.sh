#!/bin/sh

doing() {
    DOING_CARD_NUMBER=$1
    if [ -z "$DOING_CARD_NUMBER" ]; then
        doing_card $DOING_CARD_NUMBER
    elif [ -z "$DOING_CARD_NUMBER" ]; then
        list_cards "Doing"
    else
        printf $FORMAT_RED "Invalid parameter '$TODO_COMMAND' for 'doing'."
    fi
}

doing_card() {
    SELECTED_CARD_NUMBER=$1
    echo "Moving card [#$SELECTED_CARD_NUMBER] to Doing..."
    move_card $SELECTED_CARD_NUMBER "Doing"
}