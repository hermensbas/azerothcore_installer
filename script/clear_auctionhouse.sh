#!/bin/bash

sudo mysql -u root --database="acore_characters" < ${ROOT_DIR}/sql/clear_auctionhouse.sql

echo "Auction house items deleted..."
