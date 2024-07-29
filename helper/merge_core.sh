#!/bin/bash
ROOT_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"


##########################################################################################
# General dependencies
##########################################################################################
sudo apt update && sudo apt install -y git

read -p "Merge the orginal azerothcore code into the playerbot azerothcore, are you sure? (Y)es/(N)o: " -n 1 -r
echo " ";
if [[ $REPLY =~ ^[Yy]$ ]];
then
    ##########################################################################################
    # Try to merge from the orginal azerothcore into the playerbot azerothcore fork branch
    ##########################################################################################
    cd ${ROOT_DIR}/../_download/azerothcore
    git reset --hard origin/Playerbot   
    git fetch upstream
    git merge upstream/master 
    echo " "

    echo "###########################################################################################"
    echo "## If (conflict) error just run update (2_update.sh) again to restore to the latest"
    echo "## version of the playerbot branch"
    echo "###########################################################################################"

fi
