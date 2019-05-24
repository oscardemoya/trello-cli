#!/bin/sh

doing() {
    DOING_CARD_NUMBER=$1
    if [ ! -z "$DOING_CARD_NUMBER" -a "$DOING_CARD_NUMBER" != " " ]; then
        echo "Moving card [#$DOING_CARD_NUMBER] to Doing..."
        move_card $DOING_CARD_NUMBER "Doing"
    else
        list_cards "Doing"
    fi
}
