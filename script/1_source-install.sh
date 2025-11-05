#!/bin/bash

read -p "This will install the source code. Are you sure? (Y)es/(N)o: " -n 1 -r
echo " ";
if [[ $REPLY =~ ^[Yy]$ ]];
then

    ##########################################################################################
    # General dependencies
    ##########################################################################################
    sudo apt update && \
        sudo apt full-upgrade -y && \
            sudo apt-get install -y \
                unzip \
                git \
                sudo \
                git \
                btop \
                ncdu \
                unzip \
                git \
                sudo \
                git \
                tmux \
                sudo \
                curl \
                net-tools \
                locate \
                nano \
                software-properties-common

    ##########################################################################################
    # Install core dependencies (https://www.azerothcore.org/wiki/linux-requirements)
    ##########################################################################################
    sudo apt-get update -y && \
    	sudo apt-get install -y \
             git \
             cmake \
             make \
             gcc \
             g++ \
             clang \
             libmysqlclient-dev \
             libssl-dev \
             libbz2-dev \
             libreadline-dev \
             libncurses-dev \
             mysql-server \
             libboost-all-dev


    ##########################################################################################
    # Create download folder
    ##########################################################################################
    if [ ! -d "${ROOT_DIR}/_download" ]; 
    then
        mkdir ${ROOT_DIR}/_download
    else
        rm -rf ${ROOT_DIR}/_download
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
    # Clone module /mod-player-bot-level-brackets
    ##########################################################################################
    sudo rm -rf ${ROOT_DIR}/_download/modules/mod-player-bot-level-brackets > /dev/null 2>&1
    git config --global --add safe.directory "${ROOT_DIR}/_download/modules/mod-player-bot-level-brackets"
    git clone ${AC_MODE_BRACKETS_REPO} --branch=${AC_MODE_BRACKETS_REPO_BRANCH} ${ROOT_DIR}/_download/modules/mod-player-bot-level-brackets


    ##########################################################################################
    # Download client-data (only if file does not exist)
    ##########################################################################################
    if ! [ -f ${ROOT_DIR}/_data/data.zip ]; 
    then
    mkdir -p ${ROOT_DIR}/_data > /dev/null 2>&1
    sudo curl -L https://github.com/wowgaming/client-data/releases/download/v18/data.zip --output ${ROOT_DIR}/_data/data.zip
    fi


    ##########################################################################################
    # set azerothcore playerbot fork upstream with original azerothcore
    ##########################################################################################
    cd ${ROOT_DIR}/_download/azerothcore && git remote add upstream https://github.com/azerothcore/azerothcore-wotlk.git

    
    echo "Executed..."

fi
