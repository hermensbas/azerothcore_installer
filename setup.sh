#!/bin/bash

export ROOT_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

##########################################################################################
# USER CONFIG
##########################################################################################
set -a # export all variables created next
source settings.env
set +a # stop exporting

##########################################################################################
# Import system vars and aliases into ~/.bashrc
##########################################################################################
source ${ROOT_DIR}/script/0_variables.sh
echo " "
echo "###########################################################################################"
echo "## After first run TYPE 'source ~/.bashrc' !!!!!!!!"
source ${ROOT_DIR}/script/menu.sh
echo "## After first run TYPE 'source ~/.bashrc' !!!!!!!!"
echo "###########################################################################################"
