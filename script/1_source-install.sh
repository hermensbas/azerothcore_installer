#!/bin/bash

read -p "This will install the source code. Are you sure? (Y)es/(N)o: " -n 1 -r
echo " ";
if [[ $REPLY =~ ^[Yy]$ ]];
then

    ##########################################################################################
    # General dependencies
    ##########################################################################################
    sudo apt update && sudo apt install -y unzip git sudo git


    ##########################################################################################
    # Create download folder
    ##########################################################################################
    if [ ! -d "${ROOT_DIR}/_download" ]; 
    then
    mkdir ${ROOT_DIR}/_download
    fi


    ##########################################################################################
    # Clone azerothcore (playerbot fork) 
    ##########################################################################################
    sudo rm -rf ${ROOT_DIR}/_download/azerothcore > /dev/null 2>&1
    git config --global --add safe.directory "${ROOT_DIR}/_download/azerothcore"
    git clone ${AC_WOTLK_REPO} --branch=${AC_WOTLK_REPO_BRANCH} ${ROOT_DIR}/_download/azerothcore


    ##########################################################################################
    # Clone module playerbots
    ##########################################################################################
    sudo rm -rf ${ROOT_DIR}/_download/modules/mod-playerbots > /dev/null 2>&1
    git config --global --add safe.directory "${ROOT_DIR}/_download/modules/mod-playerbots"
    git clone ${AC_MODE_PLAYER_BOTS_REPO} --branch=${AC_MODE_PLAYER_BOTS_REPO_BRANCH} ${ROOT_DIR}/_download/modules/mod-playerbots 


    ##########################################################################################
    # Clone module ah-bot
    ##########################################################################################
    sudo rm -rf ${ROOT_DIR}/_download/modules/mod-ah-bot > /dev/null 2>&1
    git config --global --add safe.directory "${ROOT_DIR}/_download/modules/mod-ah-bot"
    git clone ${AC_MODE_AHBOT_REPO} --branch=${AC_MODE_AHBOT_REPO_BRANCH} ${ROOT_DIR}/_download/modules/mod-ah-bot


    ##########################################################################################
    # Download client-data (only if file does not exist)
    ##########################################################################################
    if ! [ -f ${ROOT_DIR}/_data/data.zip ]; 
    then
    mkdir -p ${ROOT_DIR}/_data > /dev/null 2>&1
    sudo curl -L https://github.com/wowgaming/client-data/releases/download/v16/data.zip --output ${ROOT_DIR}/_data/data.zip
    fi


    ##########################################################################################
    # set azerothcore playerbot fork upstream with original azerothcore
    ##########################################################################################
    cd ${ROOT_DIR}/_download/azerothcore && git remote add upstream https://github.com/azerothcore/azerothcore-wotlk.git


    ##########################################################################################
    # set folder rights to current user
    ##########################################################################################
    sudo chown -R $USER ${ROOT_DIR}

    
    echo "Executed..."

fi
