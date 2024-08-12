#!/bin/bash
export ROOT_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

##########################################################################################
# USER CONFIG
##########################################################################################
export REALM_IP="192.168.178.185"
export REALM_NAME="azerothcore.org"
export AH_BOT_MIN_ITEMS="25000"
export AH_BOT_MAX_ITEMS="30000"


##########################################################################################
# INTERNAL CONFIGS
# https://github.com/azerothcore/azerothcore-wotlk/blob/master/conf/dist
##########################################################################################
export AUTHSERVER="${ROOT_DIR}/_server/azerothcore/acore.sh run-authserver"
export WORLDSERVER="${ROOT_DIR}/_server/azerothcore/acore.sh run-worldserver"
export AUTHSERVER_SESSION="auth-session"
export WORLDSERVER_SESSION="world-session"
export MYSQL_ROOT_PASSWORD="rootpassword"
export MYSQL_USER="acore"
export MYSQL_PASSWORD="acore"
export MYSQL_DATABASE="acore_auth"
export DATAPATH="${ROOT_DIR}/_server/azerothcore/env/dist/bin"

source ${ROOT_DIR}/script/0_bashrc.sh
