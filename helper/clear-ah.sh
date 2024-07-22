#!/bin/bash

read -p "This will delete all items of the auction house, are you sure? (Y)es/(N)o: " -n 1 -r
echo " ";
if [[ $REPLY =~ ^[Yy]$ ]];
then

    sudo mysql -u root --database="acore_characters" -e "DELETE FROM auctionhouse;"

fi

