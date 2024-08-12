#!/bin/bash

sudo mysql -u root --database="acore_characters" < ${ROOT_DIR}/sql/clear_playerbots.sql

echo "Playerbots accounts and characters deleted..."
