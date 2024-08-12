#!/bin/bash

read -p "This will compile server. Are you sure? (Y)es/(N)o: " -n 1 -r
echo " ";
if [[ $REPLY =~ ^[Yy]$ ]];
then

    ##########################################################################################
    # General dependencies
    ##########################################################################################
    sudo apt update && \
        sudo apt full-upgrade -y && \
            sudo apt-get install -y btop tmux sudo curl net-tools locate nano software-properties-common


    ##########################################################################################
    # Install core dependencies (https://www.azerothcore.org/wiki/linux-requirements)
    ##########################################################################################
    sudo ${ROOT_DIR}/_server/azerothcore/acore.sh install-deps && \
        sudo apt-get update -y && \
        sudo apt-get install -y git cmake make gcc g++ clang libmysqlclient-dev libssl-dev libbz2-dev libreadline-dev libncurses-dev mysql-server libboost-all-dev


    ##########################################################################################
    # Compile the code
    # https://github.com/azerothcore/azerothcore-wotlk/blob/master/apps/compiler/compiler.sh
    ##########################################################################################
    sudo ${ROOT_DIR}/_server/azerothcore/acore.sh compiler clean
    sudo ${ROOT_DIR}/_server/azerothcore/acore.sh compiler configure
    sudo ${ROOT_DIR}/_server/azerothcore/acore.sh compiler compile


    ##########################################################################################
    # Ensure all folder and files are accesible for the current user
    ##########################################################################################
    sudo find ${ROOT_DIR}/_server/ -user root -exec sudo chown $USER: {} +


    echo "Executed..."

fi
