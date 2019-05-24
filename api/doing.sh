#!/bin/sh

doing() {
    DOING_CARD_NUMBER=$1
    if [ ! -z "$DOING_CARD_NUMBER" ]; then
        doing_card $DOING_CARD_NUMBER
    else
        list_cards "Doing"
    fi
}

doing_card() {
    SELECTED_CARD_NUMBER=$1
    echo "Moving card [#$SELECTED_CARD_NUMBER] to Doing..."
    move_card $SELECTED_CARD_NUMBER "Doing"
}