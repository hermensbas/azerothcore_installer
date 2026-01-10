#!/bin/bash

##########################################################################################
# Toggle debug mode: ./script.sh debug
##########################################################################################
DEBUG_MODE=0
if [[ "$1" == "debug" ]]; then
    DEBUG_MODE=1
fi

##########################################################################################
# Paths for logs and crash dumps
##########################################################################################
export LOGS_PATH="/tmp/ac/logs"
export CRASHES_PATH="/tmp/ac/crashes"

# Ensure directories exist
mkdir -p "$LOGS_PATH" "$CRASHES_PATH"

##########################################################################################
# Sessions
##########################################################################################
AUTHSERVER_SESSION="authserver"
WORLDSERVER_SESSION="worldserver"

# Path to binaries
AUTH_EXE="${SERVER_ROOT}/env/dist/bin/authserver"
WORLD_EXE="${SERVER_ROOT}/env/dist/bin/worldserver"

# Helper to start a tmux session
start_tmux_session() {
    local session_name=$1
    local command=$2
    local log_file=$3

    if tmux has-session -t "$session_name" 2>/dev/null; then
        echo "Tmux session '$session_name' already exists."
    else
        if tmux new-session -d -s "$session_name"; then
            echo "Created tmux session: $session_name"
        else
            echo "Error creating tmux session: $session_name"
            return 1
        fi
    fi

    # Run the command inside tmux
    tmux send-keys -t "$session_name" "export LOGS_PATH=$LOGS_PATH; export CRASHES_PATH=$CRASHES_PATH" C-m
    tmux send-keys -t "$session_name" "$command | tee -a $log_file" C-m

    echo "Running '$command' inside $session_name, logging to $log_file"
    echo
}

##########################################################################################
# Start servers
##########################################################################################

# Authserver always normal
start_tmux_session "$AUTHSERVER_SESSION" "$AUTH_EXE" "$LOGS_PATH/authserver.log"

# Worldserver normal or debug
if [[ $DEBUG_MODE -eq 1 ]]; then
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    GDB_LOG="$CRASHES_PATH/worldserver_gdb_$TIMESTAMP.log"
    WORLD_COMMAND="gdb -ex \"set logging file $GDB_LOG\" \
                   -ex \"set logging enabled on\" \
                   -ex \"run\" \
                   -ex \"bt full\" \
                   -ex \"quit\" \
                   --args $WORLD_EXE"
    echo "DEBUG MODE: Running worldserver under GDB"
else
    WORLD_COMMAND="$WORLD_EXE"
fi

start_tmux_session "$WORLDSERVER_SESSION" "$WORLD_COMMAND" "$LOGS_PATH/worldserver.log"

##########################################################################################
# Launch interactive menu if needed
##########################################################################################
source "${ROOT_DIR}/script/menu.sh"
