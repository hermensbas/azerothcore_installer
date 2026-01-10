#!/bin/bash

##########################################################################################
# Configuration
##########################################################################################
ROOT_DIR="$(pwd)"
SERVER_ROOT="$ROOT_DIR/_server/azerothcore"
LOGS_PATH="/tmp/ac/logs"
CRASHES_PATH="/tmp/ac/crashes"

AUTHSERVER_SESSION="auth-session"
WORLDSERVER_SESSION="world-session"

mkdir -p "$LOGS_PATH" "$CRASHES_PATH"

DEBUG_MODE=0
if [[ "$1" == "debug" ]]; then
    DEBUG_MODE=1
fi

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
AUTH_LOG="$LOGS_PATH/authserver_$TIMESTAMP.log"
WORLD_LOG="$LOGS_PATH/worldserver_$TIMESTAMP.log"

##########################################################################################
# Helper function to start tmux session
##########################################################################################
start_tmux_session() {
    local session_name=$1
    local command=$2
    local log_file=$3

    if tmux has-session -t "$session_name" 2>/dev/null; then
        echo "Tmux session '$session_name' already exists, sending command..."
    else
        if tmux new-session -d -s "$session_name"; then
            echo "Created tmux session: $session_name"
        else
            echo "Error creating tmux session: $session_name"
            return 1
        fi
    fi

    # Redirect output to log file (new file)
    tmux send-keys -t "$session_name" "$command | tee $log_file" C-m
    echo "Running '$command' in $session_name, logging to $log_file"
    echo
}

##########################################################################################
# Start authserver (always normal)
##########################################################################################
start_tmux_session "$AUTHSERVER_SESSION" "$SERVER_ROOT/acore.sh run-authserver" "$AUTH_LOG"

##########################################################################################
# Start worldserver
##########################################################################################
if [[ $DEBUG_MODE -eq 1 ]]; then
    # Debug mode: run binary directly under GDB
    GDB_LOG="$CRASHES_PATH/worldserver_gdb_$TIMESTAMP.log"

    GDB_CMD="gdb -ex \"set logging file $GDB_LOG\" \
               -ex \"set logging enabled on\" \
               -ex \"run\" \
               -ex \"bt full\" \
               -ex \"quit\" \
               --args $SERVER_ROOT/env/dist/bin/worldserver"

    start_tmux_session "$WORLDSERVER_SESSION" "$GDB_CMD" "$WORLD_LOG"

    echo "DEBUG MODE: worldserver running under GDB, crash log: $GDB_LOG"

else
    # Normal mode: use acore.sh for auto-restart
    start_tmux_session "$WORLDSERVER_SESSION" "$SERVER_ROOT/acore.sh run-worldserver" "$WORLD_LOG"
fi

##########################################################################################
# Optional: launch interactive menu
##########################################################################################
source "$ROOT_DIR/script/menu.sh"
