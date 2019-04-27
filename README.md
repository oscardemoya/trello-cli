# trello-cli
CLI for trello

## Overview

This repository contains shell scripts for getting data from Trello from a command line interface. Since it uses the [Trello API](https://developers.trello.com) you will need to grab an API key and generate a token. You can grab those by logging into Trello and then heading [here](https://trello.com/app-key).

Commands:

- `boards`: Lists all boards for your trello user
- `card`: Shows card details a given card number
- `cards`: Lists all cards in a given list
- `card_id`: Shows card_id for a given card number
- `doing`: Lists all cards in the 'Doing' list
- `help`: Display global or [command] help documentation
- `init`: Creates default configuration for trello commands
- `lists`: Lists all lists in the selected board
- `move_to`: Moves a card # to a given list
- `reset`: Removes default configuration
- `select_board`: Selects a trello board for a given name
- `select_board_id`: Selects a trello board for a given short id
- `show_config`: Shows current default configuration
- `todo`: Lists all cards in the 'To Do' list

## Installation

To install trello-cli run the following two commands:

```
chmod +x install.sh
./install.sh
```

To uninstall trello-cli run the following two commands:

```
chmod +x uninstall.sh
./uninstall.sh
```

## Setup

Run `trello init` into a directory where you want to link to a trello board. Enter the requested parameters (Trello `username` and `board` short link).

## License

Copyright © 2019 Oscar De Moya. All rights reserved.
