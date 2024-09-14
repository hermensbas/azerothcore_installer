#!/bin/bash

#param 1
REALM_NAME=$1;
if [ -z "$REALM_NAME" ]
then
 echo "First parameter 'REALM_NAME' is required";
 exit 1;
fi

sed -e "s/{{REALM_NAME}}/$REALM_NAME/g" \
    "${ROOT_DIR}/sql/update_realm_name.sql" > "/tmp/update_realm_name.sql"
sudo mysql -u root -p --database="acore_characters" < /tmp/update_realm_name.sql

echo " "
echo "###########################################################################################"
echo "Server realm NAME updated: ${REALM_NAME}"
echo "###########################################################################################"
