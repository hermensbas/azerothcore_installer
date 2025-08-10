#!/bin/bash

sudo mysql -u root -p --database="acore_characters" < ${ROOT_DIR}/sql/clear_auctionhouse.sql

echo "Auction house items deleted..."
