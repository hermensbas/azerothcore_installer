#!/bin/bash
export ROOT_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

##########################################################################################
# USER CONFIG
##########################################################################################
set -a # export all variables created next
source settings.env
set +a # stop exporting

##########################################################################################
# INTERNAL CONFIG
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

##########################################################################################
# Import system vars and aliases into ~/.bashrc
##########################################################################################
source ${ROOT_DIR}/script/0_bashrc.sh
echo " "
echo "###########################################################################################"
echo "## After first run TYPE 'source ~/.bashrc' !!!!!!!!"
echo "###########################################################################################"
echo " "
echo "## After the above you can use the following commands:"
echo "### install -  Download the source source-code"
echo "### update  -  Updates source-code to latest version"
echo "### build   -  Builds the server based on source-code"
echo "### compile -  Compiles the code based on the build server"
echo "### config  -  Applies the server configration"
echo "### start   -  starts auth and world in tmux sessions server"
echo "### stop    -  stops all sessions"
echo "### wow     -  logon world-server (tmux) session"
echo "### auth    -  logon auth-server (tmux) session"
echo " "
echo "###########################################################################################"
echo "## After first run TYPE 'source ~/.bashrc' !!!!!!!!"
echo "###########################################################################################"
