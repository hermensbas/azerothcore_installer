#!/bin/bash

##########################################################################################
# Apply server realm configuration
##########################################################################################
source ${ROOT_DIR}/script/update_realm_ip.sh ${REALM_IP}
source ${ROOT_DIR}/script/update_realm_ip.sh ${REALM_NAME}
echo " "


##########################################################################################
# Apply ah-bot custom configuration
##########################################################################################
source ${ROOT_DIR}/script/update_ahbot_config.sh ${AH_BOT_MIN_ITEMS} ${AH_BOT_MAX_ITEMS}
echo " "


##########################################################################################
# Clear playerbots account and characters (enforces performance and bot levels balance)
##########################################################################################
source ${ROOT_DIR}/script/clear_playerbots.sh
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
source ${ROOT_DIR}/script/menu-print.sh
