#!/bin/bash

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

if tmux send-keys -t $AUTHSERVER_SESSION "${SERVER_ROOT}/acore.sh run-authserver" C-m; then
    echo "Executed \"${SERVER_ROOT}/acore.sh run-authserver \" inside $AUTHSERVER_SESSION"
else
    echo "Error when executing \"${SERVER_ROOT}/acore.sh run-authserver\" inside $AUTHSERVER_SESSION"
fi
echo " "

if tmux send-keys -t $WORLDSERVER_SESSION "${SERVER_ROOT}/acore.sh run-worldserver" C-m; then
    echo "Executed \"${SERVER_ROOT}/acore.sh run-worldserver\" inside $WORLDSERVER_SESSION"
else
    echo "Error when executing \"${SERVER_ROOT}/acore.sh run-worldserver\" inside $WORLDSERVER_SESSION"
fi

echo " "
source ${ROOT_DIR}/script/menu.sh
