#!/bin/bash
ROOT_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"
source ${ROOT_DIR}/../variables.sh

REALM_IP=$1;
if [ -z "$REALM_IP" ]
then
 echo "First parameter 'REALM_IP' is required";
 exit 1;
fi


sed -e "s/{{REALM_IP}}/$REALM_IP/g" \
    "${ROOT_DIR}/../sql/update_realm_ip.sql" > "/tmp/update_realm_ip.sql"
sudo mysql -u root --database="acore_characters" < /tmp/update_realm_ip.sql

echo "Server realm IP updated..."