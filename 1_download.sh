#!/bin/bash
ROOT_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"
source ${ROOT_DIR}/variables.sh


read -p "This will DOWNLOAD and overwrite the current downloaded source code, are you sure? (Y)es/(N)o: " -n 1 -r
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
    git clone https://github.com/liyunfan1223/azerothcore-wotlk.git --branch=Playerbot ${ROOT_DIR}/_download/azerothcore


    ##########################################################################################
    # Clone module playerbots
    ##########################################################################################
    sudo rm -rf ${ROOT_DIR}/_download/modules/mod-playerbots > /dev/null 2>&1
    git config --global --add safe.directory "${ROOT_DIR}/_download/modules/mod-playerbots"
    git clone https://github.com/liyunfan1223/mod-playerbots.git ${ROOT_DIR}/_download/modules/mod-playerbots 


    ##########################################################################################
    # Clone module ah-bot
    ##########################################################################################
    sudo rm -rf ${ROOT_DIR}/_download/modules/mod-ah-bot > /dev/null 2>&1
    git config --global --add safe.directory "${ROOT_DIR}/_download/modules/mod-ah-bot"
    git clone https://github.com/azerothcore/mod-ah-bot.git ${ROOT_DIR}/_download/modules/mod-ah-bot


    ##########################################################################################
    # Clone module mod-progression-system
    ##########################################################################################
    sudo rm -rf ${ROOT_DIR}/_download/modules/mod-progression-system > /dev/null 2>&1
    git config --global --add safe.directory "${ROOT_DIR}/_download/modules/mod-progression-system"
    git clone  https://github.com/azerothcore/mod-progression-system.git ${ROOT_DIR}/_download/modules/mod-progression-system


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

    
    echo "Executed..."

fi
