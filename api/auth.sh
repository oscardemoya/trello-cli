#!/bin/sh

load_api_keys() {
    API_KEY="$(get_password trello-api-key)"
    API_TOKEN="$(get_password trello-api-token)"
    BASE_PATH="https://api.trello.com/1"
    AUTH_PARAMS="key=$API_KEY&token=$API_TOKEN"
}

requires_app_keys() {
    load_api_keys
    if [ -z "$API_KEY" ] | [ -z "$API_TOKEN" ]; then
        printf $FORMAT_YELLOW "You need to grab an API key and generate a token. See: https://trello.com/app-key"
        printf $FORMAT_YELLOW "Notice: these keys will be securely stored in the keychain."
        requires_api_key
        requires_api_token
        load_api_keys
    fi
}

requires_api_key() {
    if [ -z "$API_KEY" ]; then
        read -r -p "Enter your trello api key: " API_KEY
        API_KEY=${API_KEY}
        if [ -z "$API_KEY" ]; then
            printf $FORMAT_RED "A trello API key is required."
            exit 1
        fi
        set_password "trello-api-key" $API_KEY
    fi
}

requires_api_token() {
    if [ -z "$API_TOKEN" ]; then
        read -r -p "Enter your trello api token: " API_TOKEN
        API_TOKEN=${API_TOKEN}
        if [ -z "$API_TOKEN" ]; then
            printf $FORMAT_RED "A trello API token is required."
            exit 1
        fi
        set_password "trello-api-token" $API_TOKEN
    fi
}
