#!/bin/bash

ACCOUNT_NAME=$1;
if [ -z "$ACCOUNT_NAME" ]
then
 echo "First parameter 'ACCOUNT_NAME' is required";
 exit 1;
fi

sed -e "s/{{ACCOUNT_NAME}}/$ACCOUNT_NAME/g" \
  "${ROOT_DIR}/sql/find_character.sql" > "/tmp/find_character.sql"
sudo mysql -u root --database="acore_characters" < /tmp/find_character.sql

echo "Find character executed..."
