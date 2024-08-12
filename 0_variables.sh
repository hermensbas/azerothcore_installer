#!/bin/bash
ROOT_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

##########################################################################################
# USER CONFIG
##########################################################################################
REALM_IP=192.168.178.185
REALM_NAME="azerothcore.org"
AH_BOT_MIN_ITEMS=25000
AH_BOT_MAX_ITEMS=30000

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





if grep -R "bash_wow" ~/.bashrc
then
    echo "bash_wow exists";
else
    echo " " >> ~/.bashrc
    echo "if [ -f ~/.bash_wow ]; then" >> ~/.bashrc
    echo "  . ~/.bash_wow" >> ~/.bashrc
    echo "fi" >> ~/.bashrc
fi
    
echo "ROOT_DIR=${ROOT_DIR}" > ~/.bash_wow
echo "DATAPATH=${DATAPATH}" >> ~/.bash_wow
echo "alias update='${ROOT_DIR}/2_source-update.sh'" >> ~/.bash_wow
echo "alias build='${ROOT_DIR}/3_server-build.sh'" >> ~/.bash_wow
echo "alias compile='${ROOT_DIR}/4_server-compile.sh'" >> ~/.bash_wow
echo "alias config='${ROOT_DIR}/5_server-configure.sh'" >> ~/.bash_wow
echo "alias start='${ROOT_DIR}/6_server-start.sh'" >> ~/.bash_wow
echo "alias stop='tmux kill-server'" >> ~/.bash_wow
echo "alias wow='cd ${ROOT_DIR}/_server/azerothcore;tmux attach -t ${WORLDSERVER_SESSION}'" >> ~/.bash_wow
echo "alias auth='cd ${ROOT_DIR}/_server/azerothcore;tmux attach -t ${AUTHSERVER_SESSION}'" >> ~/.bash_wow
source ~/.bashrc
echo " "
echo "###########################################################################################"
echo "## After the first install or changes either reboot or TYPE! 'source ~/.bashrc'"
echo "###########################################################################################"
echo "## After the above you can use the following commands:"
echo "### update  -  Updates source-code to latest version"
echo "### build   -  Builds the server based on source-code"
echo "### compile -  Compiles the code based on the build server"
echo "### config  -  Applies the server configration"
echo "### start   -  starts auth and world in tmux sessions server"
echo "### stop    -  stops all sessions"
echo "### wow     -  logon world-server (tmux) session"
echo "### auth    -  logon auth-server (tmux) session"
echo "###########################################################################################"
