#!/bin/sh
# requires jq: `brew install jq`

get_pw() {
    security 2>&1 >/dev/null find-generic-password -gs $1 \
    | ruby -e 'print $1 if STDIN.gets =~ /^password: "(.*)"$/'
}

get_filename() {
    echo "$1" | sed "s/.*\///" | sed "s/\..*//"
}
