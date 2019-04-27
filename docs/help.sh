#!/bin/sh

show_help() {
    HELP_COMMAND=$1
    if [ "$HELP_COMMAND" == 'init' ]; then
        cat "$CURRENT_DIR/docs/help-init.txt"
    elif [ "$HELP_COMMAND" == 'boards' ]; then
        cat "$CURRENT_DIR/docs/help-boards.txt"
    elif [ -z "$HELP_COMMAND" ]; then
        cat "$CURRENT_DIR/docs/help.txt"
    else
        printf $FORMAT_RED "Help for command '$HELP_COMMAND' not found."
    fi
}
