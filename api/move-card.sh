#!/bin/sh

move_card() {
    SELECTED_LIST_NAME=$1
    SELECTED_CARD_NUMBER=$2
    board_lists "$SELECTED_LIST_NAME"
    card_id "$SELECTED_CARD_NUMBER"
    
    printf $FORMAT_WHITE "Moving trello card [#$SELECTED_CARD_ID] to '$SELECTED_LIST_NAME' list..."
    
    URL="$BASE_PATH/cards/$SELECTED_CARD_ID?idList=$SELECTED_LIST_ID&$AUTH_PARAMS"
    
    CARD=$(curl -X PUT -s $URL | jq -r '.')
    if [ ! -z "$CARD" -a "$CARD" != " " ]; then
        printf $FORMAT_GREEN "📝 Card [#$SELECTED_CARD_NUMBER] moved to '$SELECTED_LIST_NAME' list."
    else
    	printf $FORMAT_RED "Error moving the card."
    fi
}
