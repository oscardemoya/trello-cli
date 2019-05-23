#!/bin/sh

first_card() {
    require_config
    if [ -z "$1" ]; then
        printf $FORMAT_RED "List name is required. Usage 'trello first_card_in <list_name>'"
        exit 1
    fi
    SELECTED_LIST_NAME=$1
    board_lists "$SELECTED_LIST_NAME"
    printf $FORMAT_WHITE "Fetching trello cards..."
    request_list_cards
}

request_first_card() {
    URL="$BASE_PATH/lists/$SELECTED_LIST_ID/cards?fields=all&$AUTH_PARAMS"
    RESULTS=$(curl -s $URL | jq -r '.[] | @base64')
    TSV="ID\tNAME"
    ITEM=$RESULTS[0]
    if [ ! -z "$ITEM" ]; then
        _jq() {
            echo ${ITEM} | base64 --decode | jq -r ${1}
        }
        CARD_ID=$(_jq '.id')
        CARD_NUMBER=$(_jq '.idShort')
        CARD_NAME=$(_jq '.name')
        CARD_SUBSCRIBED=$(_jq '.subscribed')
    fi
}
