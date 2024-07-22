#!/bin/bash

if [ -z "$1" ]
then
 echo "Parameter is null, first paramter 'character name' should not be empty";
 exit 1;
fi

# find character and account id by name, mainly used for configuring the ah-bot mod.
sudo mysql -u root --database="acore_auth" -e "select acc.id as accountId, ch.guid as characterId from acore_auth.account as acc inner join acore_characters.characters as ch where acc.id = ch.account and acc.username = '${1}';"
