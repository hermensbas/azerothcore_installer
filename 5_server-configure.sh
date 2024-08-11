#!/bin/bash
ROOT_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"
source ${ROOT_DIR}/variables.sh


read -p "This will configur the server, are you sure? (Y)es/(N)o: " -n 1 -r
echo " ";
if [[ $REPLY =~ ^[Yy]$ ]];
then

    ##########################################################################################
    # Enable mysql server
    ##########################################################################################
    sudo service mysql start


    ##########################################################################################
    # Create acore account
    ##########################################################################################
    sudo mysql -u root -e "CREATE DATABASE IF NOT EXISTS acore_auth;"
    sudo mysql -u root -e "CREATE USER IF NOT EXISTS 'acore'@'%' IDENTIFIED BY 'acore';"
    sudo mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'acore'@'%';"
    sudo mysql -u root -e "FLUSH PRIVILEGES;"


    ##########################################################################################
    # Recompile default conf files
    ##########################################################################################
    sudo ${ROOT_DIR}/_server/azerothcore/acore.sh compiler configure


    ##########################################################################################
    # Ensure all folder and files are accesible for the current user
    ##########################################################################################
    sudo find ${ROOT_DIR}/_server/ -user root -exec sudo chown $USER: {} +


    ##########################################################################################
    # Server config merge
    ##########################################################################################
    sudo cat ${ROOT_DIR}/config/authserver.conf \
                ${ROOT_DIR}/_server/azerothcore/env/dist/etc/authserver.conf.dist > \
                    ${ROOT_DIR}/_server/azerothcore/env/dist/etc/authserver.conf | exit 1

    sudo cat ${ROOT_DIR}/config/worldserver.conf \
                ${ROOT_DIR}/_server/azerothcore/env/dist/etc/worldserver.conf.dist > \
                    ${ROOT_DIR}/_server/azerothcore/env/dist/etc/worldserver.conf | exit 1
    

    ###########################################################################################
    ## Modules config merge
    ###########################################################################################
    sudo cat ${ROOT_DIR}/config/modules/playerbots.conf \
                ${ROOT_DIR}/_server/azerothcore/env/dist/etc/modules/playerbots.conf.dist > \
                    ${ROOT_DIR}/_server/azerothcore/env/dist/etc/modules/playerbots.conf | exit 1

    sudo cat ${ROOT_DIR}/config/modules/mod_ahbot.conf \
                ${ROOT_DIR}/_server/azerothcore/env/dist/etc/modules/mod_ahbot.conf.dist > \
                    ${ROOT_DIR}/_server/azerothcore/env/dist/etc/modules/mod_ahbot.conf | exit 1


    ##########################################################################################
    # Set alias to start, stop and open wow or auth tmux sessions
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
fi
