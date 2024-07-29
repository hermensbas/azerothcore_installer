#!/bin/bash
ROOT_DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"
source ${ROOT_DIR}/variables.sh


##########################################################################################
# Apply realm settings
##########################################################################################
sudo mysql -u root --database="acore_auth" -e "UPDATE realmlist SET address = '${REALM_IP}' WHERE id = 1;"
sudo mysql -u root --database="acore_auth" -e "UPDATE realmlist SET name = '${REALM_NAME}' WHERE id = 1;"
echo "Realm settings updated..."
echo " "


##########################################################################################
# Apply ah-modbot settings
##########################################################################################
sudo mysql -u root --database="acore_world" -e "UPDATE mod_auctionhousebot SET minitems = ${AH_BOT_MIN_ITEMS}, maxitems = ${AH_BOT_MAX_ITEMS};"
echo "Module ah-modbot updated..."
echo " "


##########################################################################################
# reset playerbots data (enforces performance and bot levels balance)
##########################################################################################
sudo mysql -u root --database="acore_characters" < ${ROOT_DIR}/lib/clear-bots.sql
echo "Module playerbots updated..."
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
echo "# type in terminal: "
echo "#   - 'wow'            : for the worlds-server session"
echo "#   - 'auth'           : for the auth-server session"
echo "#   - 'ctrl+b then d'  : detach from session (if not working use ctrl-z)"
echo "#   - 'stop'           : the kill the world and auth -server sessions"
echo "#   - 'update'         :   
echo "###########################################################################################"
