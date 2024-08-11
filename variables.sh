#!/bin/bash
ROOT_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

##########################################################################################
# DO NOT MODIFY THIS FILE, SEE /config/user.env settings instead!!
##########################################################################################
set -o allexport && source ${ROOT_DIR}/config/user.env && set +o allexport

##########################################################################################
# Server and project internal variables 
# https://github.com/azerothcore/azerothcore-wotlk/blob/master/conf/dist
##########################################################################################
AUTHSERVER="${ROOT_DIR}/_server/azerothcore/acore.sh run-authserver"
WORLDSERVER="${ROOT_DIR}/_server/azerothcore/acore.sh run-worldserver"
AUTHSERVER_SESSION="auth-session"
WORLDSERVER_SESSION="world-session"

MYSQL_ROOT_PASSWORD=rootpassword
MYSQL_USER=acore
MYSQL_PASSWORD=acore
MYSQL_DATABASE=acore_auth

DATAPATH=${ROOT_DIR}/_server/azerothcore/env/dist/bin
