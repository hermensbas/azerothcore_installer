#!/bin/bash

read -p "This will compile server. Are you sure? (Y)es/(N)o: " -n 1 -r
echo " ";
if [[ $REPLY =~ ^[Yy]$ ]];
then

    ##########################################################################################
    # General dependencies
    ##########################################################################################
    #sudo apt update && \
    #    sudo apt full-upgrade -y && \
    #        sudo apt-get install -y btop ncdu tmux sudo curl net-tools locate nano software-properties-common


    ##########################################################################################
    # Install core dependencies (https://www.azerothcore.org/wiki/linux-requirements)
    ##########################################################################################
    #sudo ${ROOT_DIR}/_server/azerothcore/acore.sh install-deps && \
    #    sudo apt-get update -y && \
    #    sudo apt-get install -y git cmake make gcc g++ clang libmysqlclient-dev libssl-dev libbz2-dev libreadline-dev libncurses-dev mysql-server libboost-all-dev


    ##########################################################################################
    # Compile the code
    # https://github.com/azerothcore/azerothcore-wotlk/blob/master/apps/compiler/compiler.sh
    # when module code changed there is no need for a full compile like below 'compile all'
    # in that case 'compile build' is enough and much much faster
    # https://www.azerothcore.org/wiki/linux-core-installation
    ##########################################################################################
    export CTYPE=RelWithDebInfo
    sudo ${ROOT_DIR}/_server/azerothcore/acore.sh compiler clean
    sudo -E ${ROOT_DIR}/_server/azerothcore/acore.sh compiler configure
    sudo ${ROOT_DIR}/_server/azerothcore/acore.sh compiler compile


    ##########################################################################################
    # set folder rights to current user
    ##########################################################################################
    sudo chown -R $USER ${ROOT_DIR}


    echo "Executed..."

fi
