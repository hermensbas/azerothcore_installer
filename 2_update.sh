#!/bin/bash
ROOT_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"
source ${ROOT_DIR}/variables.sh


read -p "This will UPDATE the current downloaded source code, are you sure? (Y)es/(N)o: " -n 1 -r
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
    git -C ${ROOT_DIR}/_download/azerothcore reset --hard origin/Playerbot   


    ##########################################################################################
    # reset mod-playerbots to latest branch
    ##########################################################################################
    git -C ${ROOT_DIR}/_download/modules/mod-playerbots fetch origin
    git -C ${ROOT_DIR}/_download/modules/mod-playerbots clean -fd
    git -C ${ROOT_DIR}/_download/modules/mod-playerbots reset --hard origin/master


    ##########################################################################################
    # reset mod-ah-bot to latest branch
    ##########################################################################################
    git -C ${ROOT_DIR}/_download/modules/mod-ah-bot fetch origin
    git -C ${ROOT_DIR}/_download/modules/mod-ah-bot clean -fd
    git -C ${ROOT_DIR}/_download/modules/mod-ah-bot reset --hard origin/master


    echo "Executed..."

fi
