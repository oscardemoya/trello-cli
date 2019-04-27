#!/bin/sh
# requires jq: `brew install jq`

board_lists() {
    SELECTED_LIST_NAME=$1
    if [ ! -z "$SELECTED_LIST_NAME" -a "$SELECTED_LIST_NAME" != " " ]; then
        printf $FORMAT_WHITE "Fetching trello list '$SELECTED_LIST_NAME'..."
    else
    	printf $FORMAT_WHITE "Fetching trello lists..."
    fi
    
    URL="$BASE_PATH/boards/$BOARD_SHORT_LINK/lists?fields=id%2Cname&cards=none&card_fields=all&filter=open&$AUTH_PARAMS"
    
    RESULTS=$(curl -s $URL | jq -r '.[] | @base64')
    CSV="ID,NAME\n"
    for ITEM in $RESULTS; do
        _jq() {
            echo ${ITEM} | base64 --decode | jq -r ${1}
        }
        ITEM_ID=$(_jq '.id')
        ITEM_NAME=$(_jq '.name')
        if [ "$ITEM_NAME" == "$SELECTED_LIST_NAME" ]; then
            SELECTED_LIST_ID=$ITEM_ID
        fi
        CSV+="$ITEM_ID,$ITEM_NAME\n"
    done

    if [ ! -z "$SELECTED_LIST_NAME" -a "$SELECTED_LIST_NAME" != " " ]; then
        if [ ! -z "$SELECTED_LIST_ID" -a "$SELECTED_LIST_ID" != " " ]; then
            printf $FORMAT_YELLOW "🗒  List '$SELECTED_LIST_NAME' [$SELECTED_LIST_ID] found."
        else
        	printf $FORMAT_RED "List not found."
        fi
    else
        NUMBER_OF_LINES=$(echo "$CSV" | wc -l)
        if [ $NUMBER_OF_LINES -gt 1 ]; then
            echo "$CSV" | column -t -s,
        else
            printf $FORMAT_RED "No lists found."
        fi
    fi
}
