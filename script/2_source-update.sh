#!/bin/bash

read -p "This will update the source code. Are you sure? (Y)es/(N)o: " -n 1 -r
echo " ";
if [[ $REPLY =~ ^[Yy]$ ]];
then

    ##########################################################################################
    # General dependencies
    ##########################################################################################
    sudo apt update && sudo apt install -y git


    ##########################################################################################
    # reset azerothcore to latest branch
    ##########################################################################################
    git -C ${ROOT_DIR}/_download/azerothcore fetch origin
    git -C ${ROOT_DIR}/_download/azerothcore clean -fd
    git -C ${ROOT_DIR}/_download/azerothcore reset --hard origin/${AC_WOTLK_REPO_BRANCH}   


    ##########################################################################################
    # reset mod-playerbots to latest branch
    ##########################################################################################
    git -C ${ROOT_DIR}/_download/modules/mod-playerbots fetch origin
    git -C ${ROOT_DIR}/_download/modules/mod-playerbots clean -fd
    git -C ${ROOT_DIR}/_download/modules/mod-playerbots reset --hard origin/${AC_MODE_PLAYER_BOTS_REPO_BRANCH}


    ##########################################################################################
    # reset mod-ah-bot to latest branch
    ##########################################################################################
    git -C ${ROOT_DIR}/_download/modules/mod-ah-bot fetch origin
    git -C ${ROOT_DIR}/_download/modules/mod-ah-bot clean -fd
    git -C ${ROOT_DIR}/_download/modules/mod-ah-bot reset --hard origin/${AC_MODE_AHBOT_REPO_BRANCH}


    ##########################################################################################
    # set folder rights to current user
    ##########################################################################################
    sudo chown -R $USER ${ROOT_DIR}


    echo "Executed..."

fi
