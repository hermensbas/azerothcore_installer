#!/bin/bash

export ROOT_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

##########################################################################################
# USER CONFIG
##########################################################################################
set -a; source settings.env; set +a


##########################################################################################
# INTERNAL CONFIG
##########################################################################################
SERVER_ROOT="${ROOT_DIR}/_server/azerothcore"
DATAPATH="${SERVER_ROOT}/env/dist/bin"

AUTHSERVER_SESSION="auth-session"
WORLDSERVER_SESSION="world-session"

MYSQL_ROOT_PASSWORD="rootpassword"
MYSQL_USER="acore"
MYSQL_PASSWORD="acore"
MYSQL_DATABASE="acore_auth"


##########################################################################################
# add chmod rights
##########################################################################################
sudo chmod +x ${ROOT_DIR}/script/*.sh


##########################################################################################
# add ~/.bash_wow to ~/.bashrc if not exist
##########################################################################################
if grep -R "bash_wow" ~/.bashrc
then
    echo "bash_wow exists";
else
    echo " " >> ~/.bashrc
    echo "if [ -f ~/.bash_wow ]; then" >> ~/.bashrc
    echo "  . ~/.bash_wow" >> ~/.bashrc
    echo "fi" >> ~/.bashrc
fi


##########################################################################################
# add variables to ~/.bash_wow
##########################################################################################
echo "export ROOT_DIR=${ROOT_DIR}" > ~/.bash_wow
echo "export SERVER_ROOT=${SERVER_ROOT}" >> ~/.bash_wow

echo "export AC_WOTLK_REPO=${AC_WOTLK_REPO}" >> ~/.bash_wow
echo "export AC_WOTLK_REPO_BRANCH=${AC_WOTLK_REPO_BRANCH}" >> ~/.bash_wow

echo "export AC_MODE_PLAYER_BOTS_REPO=${AC_MODE_PLAYER_BOTS_REPO}" >> ~/.bash_wow
echo "export AC_MODE_PLAYER_BOTS_REPO_BRANCH=${AC_MODE_PLAYER_BOTS_REPO_BRANCH}" >> ~/.bash_wow

echo "export AC_MODE_AHBOT_REPO=${AC_MODE_AHBOT_REPO}" >> ~/.bash_wow
echo "export AC_MODE_AHBOT_REPO_BRANCH=${AC_MODE_AHBOT_REPO_BRANCH}" >> ~/.bash_wow

echo "export AC_MODE_BRACKETS_REPO=${AC_MODE_BRACKETS_REPO}" >> ~/.bash_wow
echo "export AC_MODE_BRACKETS_REPO_BRANCH=${AC_MODE_BRACKETS_REPO_BRANCH}" >> ~/.bash_wow

echo "export DATAPATH=${DATAPATH}" >> ~/.bash_wow

echo "export AUTHSERVER_SESSION=${AUTHSERVER_SESSION}" >> ~/.bash_wow
echo "export WORLDSERVER_SESSION=${WORLDSERVER_SESSION}" >> ~/.bash_wow

echo "export MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}" >> ~/.bash_wow
echo "export MYSQL_USER=${MYSQL_USER}" >> ~/.bash_wow
echo "export MYSQL_PASSWORD=${MYSQL_PASSWORD}" >> ~/.bash_wow
echo "export MYSQL_DATABASE=${MYSQL_DATABASE}" >> ~/.bash_wow

echo "export REALM_IP=${REALM_IP}" >> ~/.bash_wow
echo "export REALM_NAME=${REALM_NAME}" >> ~/.bash_wow

echo "export AH_BOT_MIN_ITEMS=${AH_BOT_MIN_ITEMS}" >> ~/.bash_wow
echo "export AH_BOT_MAX_ITEMS=${AH_BOT_MAX_ITEMS}" >> ~/.bash_wow


##########################################################################################
#  add alias to ~/.bash_wow
##########################################################################################
echo "alias menu='${ROOT_DIR}/script/menu.sh'" >> ~/.bash_wow
echo "alias install='${ROOT_DIR}/script/1_source-install.sh'" >> ~/.bash_wow
echo "alias update='${ROOT_DIR}/script/2_source-update.sh'" >> ~/.bash_wow
echo "alias build='${ROOT_DIR}/script/3_server-build.sh'" >> ~/.bash_wow
echo "alias compile='${ROOT_DIR}/script/4_server-compile.sh'" >> ~/.bash_wow
echo "alias config='${ROOT_DIR}/script/5_server-configure.sh'" >> ~/.bash_wow
echo "alias start='${ROOT_DIR}/script/6_server-start.sh'" >> ~/.bash_wow
echo "alias stop='tmux kill-server'" >> ~/.bash_wow
echo "alias wow='cd ${SERVER_ROOT};tmux attach -t ${WORLDSERVER_SESSION}'" >> ~/.bash_wow
echo "alias auth='cd ${SERVER_ROOT};tmux attach -t ${AUTHSERVER_SESSION}'" >> ~/.bash_wow


##########################################################################################
# Print menu
##########################################################################################
echo " "
echo "###########################################################################################"
echo "## After first run TYPE 'source ~/.bashrc' !!!!!!!!"
source ${ROOT_DIR}/script/menu.sh
echo "## After first run TYPE 'source ~/.bashrc' !!!!!!!!"
echo "###########################################################################################"
