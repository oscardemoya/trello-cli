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
        _jqjoined() {
            MODEL=${1}
            FIELD=${2}
            echo $CARD | base64 --decode | jq -r $MODEL' | map('$FIELD') | join(", ")'
        }
        printf $FORMAT_YELLOW "📝 Card [#$SELECTED_CARD_NUMBER]"
        SELECTED_CARD_ID=$(_jq '.id')
        echo "ID: $SELECTED_CARD_ID"
        echo "URL: $(_jq '.shortUrl')"
        echo "NAME: $(_jq '.name')"
        echo "DESC: $(_jq '.desc')"
        echo "LABELS: $(_jqjoined '.labels' '.name')"
        echo "MEMBERS: $(_jqjoined '.members' '.fullName')"
        echo "CHECKLISTS:"
        request_checklists $SELECTED_CARD_ID
    else
    	printf $FORMAT_RED "Card not found."
    fi
}

request_checklists() {
    SELECTED_CARD_ID=$1
    URL="$BASE_PATH/cards/$SELECTED_CARD_ID/checklists?fields=all&$AUTH_PARAMS"
    RESULTS=$(curl -s $URL | jq -r '.[] | @base64')
    for ITEM in $RESULTS; do
        _jqc() {
            echo ${ITEM} | base64 --decode | jq -r ${1}
        }
        CHECKLIST_NAME=$(_jqc '.name')
        echo "- $CHECKLIST_NAME"
        CHECK_ITEMS=$(_jqc '.checkItems')
        for CHECK_ITEM in $(echo "${CHECK_ITEMS}" | jq -r '.[] | @base64'); do
            _jqci() {
                echo ${CHECK_ITEM} | base64 --decode | jq -r ${1}
            }
            CHECK_ITEM_STATE=$(_jqci '.state')
            [[ $CHECK_ITEM_STATE = "complete" ]] && CHECKED="✓" || CHECKED=" "
            echo "  [$CHECKED] $(_jqci '.name')"
        done
    done
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
