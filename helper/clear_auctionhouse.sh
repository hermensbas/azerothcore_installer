#!/bin/bash
AH_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"
source ${AH_DIR}/../variables.sh

sudo mysql -u root --database="acore_characters" < ${AH_DIR}/../sql/clear_auctionhouse.sql

echo "Auction house items deleted..."
