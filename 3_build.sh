#!/bin/bash
ROOT_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"
source ${ROOT_DIR}/variables.sh


read -p "This will (re)build the server with the downloaded resources, are you sure? (Y)es/(N)o: " -n 1 -r
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



    echo "Executed..."

fi
