#!/bin/bash
ROOT_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"
source ${ROOT_DIR}/variables.sh


read -p "This will configur the server, are you sure? (Y)es/(N)o: " -n 1 -r
echo " ";
if [[ $REPLY =~ ^[Yy]$ ]];
then

    ##########################################################################################
    # Enable mysql server
    ##########################################################################################
    sudo service mysql start


    ##########################################################################################
    # Create acore account
    ##########################################################################################
    sudo mysql -u root -e "CREATE DATABASE IF NOT EXISTS acore_auth;"
    sudo mysql -u root -e "CREATE USER IF NOT EXISTS 'acore'@'%' IDENTIFIED BY 'acore';"
    sudo mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'acore'@'%';"
    sudo mysql -u root -e "FLUSH PRIVILEGES;"


    ##########################################################################################
    # Recompile default conf files
    ##########################################################################################
    sudo ${ROOT_DIR}/_server/azerothcore/acore.sh compiler configure


    ##########################################################################################
    # Ensure all folder and files are accesible for the current user
    ##########################################################################################
    sudo find ${ROOT_DIR}/_server/ -user root -exec sudo chown $USER: {} +


    ##########################################################################################
    # Server config merge
    ##########################################################################################
    sudo cat ${ROOT_DIR}/config/authserver.conf \
                ${ROOT_DIR}/_server/azerothcore/env/dist/etc/authserver.conf.dist > \
                    ${ROOT_DIR}/_server/azerothcore/env/dist/etc/authserver.conf | exit 1

    sudo cat ${ROOT_DIR}/config/worldserver.conf \
                ${ROOT_DIR}/_server/azerothcore/env/dist/etc/worldserver.conf.dist > \
                    ${ROOT_DIR}/_server/azerothcore/env/dist/etc/worldserver.conf | exit 1
    

    ###########################################################################################
    ## Modules config merge
    ###########################################################################################
    sudo cat ${ROOT_DIR}/config/modules/playerbots.conf \
                ${ROOT_DIR}/_server/azerothcore/env/dist/etc/modules/playerbots.conf.dist > \
                    ${ROOT_DIR}/_server/azerothcore/env/dist/etc/modules/playerbots.conf | exit 1

    sudo cat ${ROOT_DIR}/config/modules/mod_ahbot.conf \
                ${ROOT_DIR}/_server/azerothcore/env/dist/etc/modules/mod_ahbot.conf.dist > \
                    ${ROOT_DIR}/_server/azerothcore/env/dist/etc/modules/mod_ahbot.conf | exit 1

fi
