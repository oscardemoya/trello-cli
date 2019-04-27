#!/bin/sh

load_api_keys() {
    API_KEY="$(get_pw trello-api-key)"
    API_TOKEN="$(get_pw trello-api-token)"
    BASE_PATH="https://api.trello.com/1"
    AUTH_PARAMS="key=$API_KEY&token=$API_TOKEN"
}