#!/bin/bash

##########################################################################################
# Apply server realm configuration
##########################################################################################
source ${ROOT_DIR}/helper/update_realm_ip.sh ${REALM_IP}
source ${ROOT_DIR}/helper/update_realm_ip.sh ${REALM_NAME}
echo " "


##########################################################################################
# Apply ah-bot custom configuration
##########################################################################################
source ${ROOT_DIR}/helper/update_ahbot_config.sh ${AH_BOT_MIN_ITEMS} ${AH_BOT_MAX_ITEMS}
echo " "


##########################################################################################
# Clear playerbots account and characters (enforces performance and bot levels balance)
##########################################################################################
source ${ROOT_DIR}/helper/clear_playerbots.sh
echo " "


##########################################################################################
# handle the tmux sessions
##########################################################################################
if tmux new-session -d -s $AUTHSERVER_SESSION; then
    echo "Created authserver session: $AUTHSERVER_SESSION"
else
    echo "Error when trying to create authserver session: $AUTHSERVER_SESSION"
fi
echo " "

if tmux new-session -d -s $WORLDSERVER_SESSION; then
    echo "Created worldserver session: $WORLDSERVER_SESSION"
else
    echo "Error when trying to create worldserver session: $WORLDSERVER_SESSION"
fi
echo " "

if tmux send-keys -t $AUTHSERVER_SESSION "$AUTHSERVER" C-m; then
    echo "Executed \"$AUTHSERVER\" inside $AUTHSERVER_SESSION"
    #echo "You can attach to $AUTHSERVER_SESSION and check the result using \"tmux attach -t $AUTHSERVER_SESSION\""
else
    echo "Error when executing \"$AUTHSERVER\" inside $AUTHSERVER_SESSION"
fi
echo " "

if tmux send-keys -t $WORLDSERVER_SESSION "$WORLDSERVER" C-m; then
    echo "Executed \"$WORLDSERVER\" inside $WORLDSERVER_SESSION"
    #echo "You can attach to $WORLDSERVER_SESSION and check the result using \"tmux attach -t $WORLDSERVER_SESSION\""
else
    echo "Error when executing \"$WORLDSERVER\" inside $WORLDSERVER_SESSION"
fi

echo " "
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
