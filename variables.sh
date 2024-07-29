#!/bin/bash
ROOT_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"


##########################################################################################
# If you want remote players to connect use the following info e.g. 
# router DMZ or poort-forwarding and possibly firewall settings.
##########################################################################################
# 3724 TCP AUTH-SERVER
# 8085 TCP WORLD-SERVER


##########################################################################################
# Variables # https://github.com/azerothcore/azerothcore-wotlk/blob/master/conf/dist/env.ac
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

# ----------------------------------------------------------------------------------------
# if you want remore players to connects then this should the external IP/DNS
# which also should be placed in the 3.35a client Realm.wtf
# ----------------------------------------------------------------------------------------
REALM_IP=192.168.178.185
REALM_NAME="azerothcore.org"

AH_BOT_MIN_ITEMS=25000
AH_BOT_MAX_ITEMS=30000
