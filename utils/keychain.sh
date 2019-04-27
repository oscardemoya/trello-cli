#!/bin/sh

get_password() {
    security 2>&1 >/dev/null find-generic-password -gs $1 \
    | ruby -e 'print $1 if STDIN.gets =~ /^password: "(.*)"$/'
}

set_password() {
    SERVICE_NAME=$1
    PASSWORD=$2
    security add-generic-password -a ${USER} -s $SERVICE_NAME -w $PASSWORD
}

delete_password() {
    SERVICE_NAME=$1
    DELETED=$(security -q delete-generic-password -s $SERVICE_NAME)
}
