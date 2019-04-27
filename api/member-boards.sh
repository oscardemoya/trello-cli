#!/bin/sh

member_boards() {
    require_username
    if [ -z "$1" ]; then
        SELECTED_USERNAME=$USERNAME
    else
        SELECTED_USERNAME=$1
    fi
    SELECTED_BOARD_NAME=$2
    if [ ! -z "$SELECTED_BOARD_NAME" -a "$SELECTED_BOARD_NAME" != " " ]; then
        printf $FORMAT_WHITE "Fetching trello board '$SELECTED_BOARD_NAME'..."
    else
    	printf $FORMAT_WHITE "Fetching trello boards for $SELECTED_USERNAME..."
    fi
    request_member_boards $SELECTED_USERNAME "$SELECTED_BOARD_NAME"
}

request_member_boards() {
    SELECTED_USERNAME=$1
    SELECTED_BOARD_NAME=$2
    URL="$BASE_PATH/members/$SELECTED_USERNAME/boards?fields=shortLink%2Cname%2Curl&filter=open&$AUTH_PARAMS"
    RESULTS=$(curl -s $URL | jq -r '.[] | @base64')
    CSV="SHORT_LINK,NAME,URL\n"
    for ITEM in $RESULTS; do
        _jq() {
            echo ${ITEM} | base64 --decode | jq -r ${1}
        }
        ITEM_SHORT_LINK=$(_jq '.shortLink')
        ITEM_NAME=$(_jq '.name')
        ITEM_URL=$(_jq '.url')
        if [ ! -z "$SELECTED_BOARD_NAME" -a "$ITEM_NAME" == "$SELECTED_BOARD_NAME" ]; then
            SELECTED_BOARD_SHORT_LINK=$ITEM_SHORT_LINK
            SELECTED_BOARD_NAME=$ITEM_NAME
            SELECTED_BOARD_URL=$ITEM_URL
            printf $FORMAT_YELLOW "🗒  Board '$SELECTED_BOARD_NAME' ($SELECTED_BOARD_URL) found."
        fi
        CSV+="$ITEM_SHORT_LINK,$ITEM_NAME,$ITEM_URL\n"
    done
    show_member_boards "$CSV"
}

show_member_boards() {
    CSV=$1
    NUMBER_OF_LINES=$(echo "$CSV" | wc -l)
    if [ ! -z "$SELECTED_BOARD_NAME" -a "$SELECTED_BOARD_NAME" != " " ]; then
        if [ -z "$SELECTED_BOARD_SHORT_LINK" ]; then
        	printf $FORMAT_RED "Board not found."
        fi
    else
        if [ $NUMBER_OF_LINES -gt 1 ]; then
            printTable ',' "$CSV"
        else
            printf $FORMAT_RED "No boards not found." 
        fi
    fi
}