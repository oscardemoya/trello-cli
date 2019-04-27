#!/bin/sh

card() {
    SELECTED_CARD_NUMBER=$1
    
    printf $FORMAT_WHITE "Fetching trello card [#$SELECTED_CARD_NUMBER]..."
    
    URL="$BASE_PATH/boards/$BOARD_SHORT_LINK/cards/$SELECTED_CARD_NUMBER?fields=all&members=true&member_fields=all&$AUTH_PARAMS"

    CARD=$(curl -s $URL | jq -r '. | @base64')
    if [ ! -z "$CARD" -a "$CARD" != " " ]; then
        _jq() {
            echo $CARD | base64 --decode | jq -r ${1}
        }
        printf $FORMAT_YELLOW "📝 Card [#$SELECTED_CARD_NUMBER]"
        echo "ID: $(_jq '.id')"
        echo "URL: $(_jq '.shortUrl')"
        echo "NAME: $(_jq '.name')"
        echo "LABELS:"
        LABELS=$(_jq '.labels')
        for LABEL in $(echo "${LABELS}" | jq -r '.[] | @base64'); do
            _jql() {
                echo ${LABEL} | base64 --decode | jq -r ${1}
            }
           echo "- $(_jql '.name')"
        done
        echo "MEMBERS:"
        MEMBERS=$(_jq '.members')
        for MEMBER in $(echo "${MEMBERS}" | jq -r '.[] | @base64'); do
            _jqm() {
                echo ${MEMBER} | base64 --decode | jq -r ${1}
            }
           echo "- $(_jqm '.fullName')"
        done
    else
    	printf $FORMAT_RED "Card not found."
    fi
}

card_id() {
    SELECTED_CARD_NUMBER=$1
    
    printf $FORMAT_WHITE "Fetching id for trello card [#$SELECTED_CARD_NUMBER]..."
    
    URL="$BASE_PATH/boards/$BOARD_SHORT_LINK/cards/$SELECTED_CARD_NUMBER?fields=all&members=true&member_fields=all&$AUTH_PARAMS"

    CARD=$(curl -s $URL | jq -r '. | @base64')
    if [ ! -z "$CARD" -a "$CARD" != " " ]; then
        _jq() {
            echo $CARD | base64 --decode | jq -r ${1}
        }
        SELECTED_CARD_ID=$(_jq '.id')
        printf $FORMAT_YELLOW "📝 Card [#$SELECTED_CARD_NUMBER] (id: $SELECTED_CARD_ID) found."
    else
    	printf $FORMAT_RED "Card not found."
    fi
}
