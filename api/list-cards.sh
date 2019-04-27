#!/bin/sh

list_cards() {
    require_config
    if [ -z "$1" ]; then
        printf $FORMAT_RED "List name is required. Usage 'trello cards <list_name>'"
        exit 1
    fi
    SELECTED_LIST_NAME=$1
    board_lists "$SELECTED_LIST_NAME"
    printf $FORMAT_WHITE "Fetching trello cards..."
    request_list_cards
}

request_list_cards() {
    URL="$BASE_PATH/lists/$SELECTED_LIST_ID/cards?fields=all&$AUTH_PARAMS"
    RESULTS=$(curl -s $URL | jq -r '.[] | @base64')
    TSV="ID\tNAME"
    for LIST in $RESULTS; do
        _jq() {
            echo ${LIST} | base64 --decode | jq -r ${1}
        }
        CARD_ID=$(_jq '.id')
        CARD_NUMBER=$(_jq '.idShort')
        CARD_NAME=$(_jq '.name')
        CARD_SUBSCRIBED=$(_jq '.subscribed')
        if [ "$CARD_SUBSCRIBED" == "true" ]; then
            TSV+="\n$CARD_NUMBER\t$CARD_NAME"
        fi
    done
    show_list_cards "$TSV"
}

show_list_cards() {
    TSV=$1
    NUMBER_OF_LINES=$(echo "$TSV" | wc -l)
    if [ $NUMBER_OF_LINES -gt 1 ]; then
        echo "$TSV"
    else
        printf $FORMAT_RED "No cards not found." 
    fi
}