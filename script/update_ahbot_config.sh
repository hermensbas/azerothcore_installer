#!/bin/bash

# param 1
AH_BOT_MIN_ITEMS=$1;
if [ -z "$AH_BOT_MIN_ITEMS" ]
then
 echo "First parameter 'AH_BOT_MIN_ITEMS' is required";
 echo "Second parameter 'AH_BOT_MAX_ITEMS' is required";
 exit 1;
fi

# param 2
AH_BOT_MAX_ITEMS=$2;
if [ -z "$AH_BOT_MAX_ITEMS" ]
then
 echo "Second parameter 'AH_BOT_MAX_ITEMS' is required";
 exit 1;
fi

sed -e "s/{{AH_BOT_MIN_ITEMS}}/$AH_BOT_MIN_ITEMS/g" \
    -e "s/{{AH_BOT_MAX_ITEMS}}/$AH_BOT_MAX_ITEMS/g" \
    "${ROOT_DIR}/sql/update_ahbot_config.sql" > "/tmp/update_ahbot_config.sql"
sudo mysql -u root --database="acore_characters" < /tmp/update_ahbot_config.sql


echo "AH-bot config updated..."
