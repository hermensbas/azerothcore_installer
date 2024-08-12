#!/bin/bash

#----------------------------------------------------------------------------------------
# add chmod rights
#----------------------------------------------------------------------------------------
sudo chmod +x ${ROOT_DIR}/*.sh
sudo chmod +x ${ROOT_DIR}/helper/*.sh

#----------------------------------------------------------------------------------------
# Add ~/.bash_wow to ~/.bashrc if not exist
#----------------------------------------------------------------------------------------
if grep -R "bash_wow" ~/.bashrc
then
    echo "bash_wow exists";
else
    echo " " >> ~/.bashrc
    echo "if [ -f ~/.bash_wow ]; then" >> ~/.bashrc
    echo "  . ~/.bash_wow" >> ~/.bashrc
    echo "fi" >> ~/.bashrc
fi

#----------------------------------------------------------------------------------------
# Add variables to ~/.bash_wow
#----------------------------------------------------------------------------------------
echo "export ROOT_DIR=${ROOT_DIR}" > ~/.bash_wow
echo "export REALM_IP=${REALM_IP}" >> ~/.bash_wow
echo "export REALM_NAME=${REALM_NAME}" >> ~/.bash_wow
echo "export AH_BOT_MIN_ITEMS=${AH_BOT_MIN_ITEMS}" >> ~/.bash_wow
echo "export AH_BOT_MAX_ITEMS=${AH_BOT_MAX_ITEMS}" >> ~/.bash_wow
echo "export AUTHSERVER=${AUTHSERVER}" >> ~/.bash_wow
echo "export WORLDSERVER=${WORLDSERVER}" >> ~/.bash_wow
echo "export AUTHSERVER_SESSION=${AUTHSERVER_SESSION}" >> ~/.bash_wow
echo "export WORLDSERVER_SESSION=${WORLDSERVER_SESSION}" >> ~/.bash_wow
echo "export MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}" >> ~/.bash_wow
echo "export MYSQL_USER=${MYSQL_USER}" >> ~/.bash_wow
echo "export MYSQL_PASSWORD=${MYSQL_PASSWORD}" >> ~/.bash_wow
echo "export MYSQL_DATABASE=${MYSQL_DATABASE}" >> ~/.bash_wow
echo "export DATAPATH=${DATAPATH}" >> ~/.bash_wow

#----------------------------------------------------------------------------------------
# Add alias to ~/.bash_wow
#----------------------------------------------------------------------------------------
echo "alias install='${ROOT_DIR}/1_source-install.sh'" >> ~/.bash_wow
echo "alias update='${ROOT_DIR}/2_source-update.sh'" >> ~/.bash_wow
echo "alias build='${ROOT_DIR}/3_server-build.sh'" >> ~/.bash_wow
echo "alias compile='${ROOT_DIR}/4_server-compile.sh'" >> ~/.bash_wow
echo "alias config='${ROOT_DIR}/5_server-configure.sh'" >> ~/.bash_wow
echo "alias start='${ROOT_DIR}/6_server-start.sh'" >> ~/.bash_wow
echo "alias stop='tmux kill-server'" >> ~/.bash_wow
echo "alias wow='cd ${ROOT_DIR}/_server/azerothcore;tmux attach -t ${WORLDSERVER_SESSION}'" >> ~/.bash_wow
echo "alias auth='cd ${ROOT_DIR}/_server/azerothcore;tmux attach -t ${AUTHSERVER_SESSION}'" >> ~/.bash_wow
