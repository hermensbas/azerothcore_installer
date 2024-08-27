#!/bin/bash

read -p "This will build server. Are you sure? (Y)es/(N)o: " -n 1 -r
echo " ";
if [[ $REPLY =~ ^[Yy]$ ]];
then

    ##########################################################################################
    # General dependencies
    ##########################################################################################
    sudo apt update && sudo apt install -y unzip


    ##########################################################################################
    # Rebuild server folder based on downloaded source codes
    ##########################################################################################
    sudo rm -rf ${ROOT_DIR}/_server > /dev/null 2>&1
    mkdir -p ${ROOT_DIR}/_server/azerothcore/modules && \
        cp -r ${ROOT_DIR}/_download/azerothcore ${ROOT_DIR}/_server && \
            cp -r ${ROOT_DIR}/_download/modules ${ROOT_DIR}/_server/azerothcore || exit 1


    ##########################################################################################
    # Copy client-data into server folder (instead of ./acore.sh client-data)
    ##########################################################################################
    unzip ${ROOT_DIR}/_data/data.zip -d ${DATAPATH} || exit 1


    ##########################################################################################
    # set folder rights to current user
    ##########################################################################################
    sudo chown -R $USER ${ROOT_DIR}
    

    echo "Executed..."

fi
