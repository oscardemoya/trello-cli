#!/bin/sh
# requires jq: `brew install jq`

board_lists() {
    SELECTED_LIST_NAME=$1
    if [ ! -z "$SELECTED_LIST_NAME" -a "$SELECTED_LIST_NAME" != " " ]; then
        printf $FORMAT_WHITE "Fetching trello list '$SELECTED_LIST_NAME'..."
    else
    	printf $FORMAT_WHITE "Fetching trello lists..."
    fi
    
    URL="$BASE_PATH/boards/$BOARD_ID/lists?fields=id%2Cname&cards=none&card_fields=all&filter=open&$AUTH_PARAMS"
    
    LISTS=$(curl -s $URL | jq -r '.[] | @base64')
    CSV="ID,NAME\n"
    for LIST in $LISTS; do
        _jq() {
            echo ${LIST} | base64 --decode | jq -r ${1}
        }
        LIST_ID=$(_jq '.id')
        LIST_NAME=$(_jq '.name')
        if [ "$LIST_NAME" == "$SELECTED_LIST_NAME" ]; then
            SELECTED_LIST_ID=$LIST_ID
        fi
        CSV+="$LIST_ID,$LIST_NAME\n"
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
