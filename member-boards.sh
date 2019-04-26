#!/bin/sh
# requires jq: `brew install jq`

member_boards() {
    if [ -z "$1" ]; then
        if [ -z "$USERNAME" ]; then
            read -r -p "Enter your trello username: " USERNAME
            USERNAME=${USERNAME}
            if [ -z "USERNAME" ]; then
                echo "Username is required."
                exit 1
            fi
            set_config USERNAME $USERNAME
        fi
    else
        USERNAME=$1
    fi
    
    SELECTED_BOARD_NAME=$2
    if [ ! -z "$SELECTED_BOARD_NAME" -a "$SELECTED_BOARD_NAME" != " " ]; then
        printf $FORMAT_WHITE "Fetching trello board '$SELECTED_BOARD_NAME'..."
    else
    	printf $FORMAT_WHITE "Fetching trello boards..."
    fi
    
    URL="$BASE_PATH/members/$USERNAME/boards?fields=id%2CshortLink%2Cname%2Curl&filter=open&$AUTH_PARAMS"
    BOARDS=$(curl -s $URL | jq -r '.[] | @base64')
    CSV="SHORT_LINK,NAME,URL\n"
    for BOARD in $BOARDS; do
        _jq() {
            echo ${BOARD} | base64 --decode | jq -r ${1}
        }
        BOARD_ID=$(_jq '.id')
        BOARD_SHORT_LINK=$(_jq '.shortLink')
        BOARD_NAME=$(_jq '.name')
        BOARD_URL=$(_jq '.url')
        if [ "$BOARD_NAME" == "$SELECTED_BOARD_NAME" ]; then
            SELECTED_BOARD_ID=$BOARD_ID
            SELECTED_BOARD_SHORT_LINK=$BOARD_SHORT_LINK
            SELECTED_BOARD_NAME=$BOARD_NAME
            SELECTED_BOARD_URL=$BOARD_URL
        fi
        CSV+="$BOARD_SHORT_LINK,$BOARD_NAME,$BOARD_URL\n"
    done
    
    NUMBER_OF_LINES=$(echo "$CSV" | wc -l)
    if [ ! -z "$SELECTED_BOARD_NAME" -a "$SELECTED_BOARD_NAME" != " " ]; then
        if [ ! -z "$SELECTED_BOARD_ID" -a "$SELECTED_BOARD_ID" != " " ]; then
            printf $FORMAT_YELLOW "🗒  Board '$SELECTED_BOARD_NAME' ($SELECTED_BOARD_URL) found."
        else
        	printf $FORMAT_RED "Board not found."
        fi
    else
        if [ $NUMBER_OF_LINES -gt 1 ]; then
            echo "$CSV" | column -t -s,
        else
            printf $FORMAT_RED "No boards not found." 
        fi
    fi
}
