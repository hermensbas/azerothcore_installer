#!/bin/bash
ROOT_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"/
source ${ROOT_DIR}/../variables.sh

sudo mysql -u root --database="acore_characters" < ${ROOT_DIR}/../sql/clear_playerbots.sql

echo "Playerbots accounts and characters deleted..."
