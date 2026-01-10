#!/bin/bash

##########################################################################################
# Paths for logs and crash dumps
##########################################################################################
export LOGS_PATH="/tmp/ac/logs"
export CRASHES_PATH="/tmp/ac/crashes"
mkdir -p "$LOGS_PATH" "$CRASHES_PATH"

##########################################################################################
# Sessions
##########################################################################################
AUTHSERVER_SESSION="auth-session"
WORLDSERVER_SESSION="world-session"

##########################################################################################
# Helper to start a tmux session and run a command
##########################################################################################
start_tmux_session() {
    local session_name=$1
    local command=$2
    local log_file=$3

    # Create session if it doesn't exist
    if tmux has-session -t "$session_name" 2>/dev/null; then
        echo "Tmux session '$session_name' already exists, attaching command..."
    else
        if tmux new-session -d -s "$session_name"; then
            echo "Created tmux session: $session_name"
        else
            echo "Error creating tmux session: $session_name"
            return 1
        fi
    fi

    # Run the command in tmux and pipe to tee
    tmux send-keys -t "$session_name" "$command 2>&1 | tee $log_file" C-m
    echo "Running '$command' in $session_name, logging to $log_file"
    echo
}

##########################################################################################
# Determine mode (debug or normal)
##########################################################################################
MODE="$1"  # script.sh debug
DEBUG_MODE=0
if [[ "$MODE" == "debug" ]]; then
    DEBUG_MODE=1
fi

##########################################################################################
# Prepare timestamped logs
##########################################################################################
AUTH_LOG="$LOGS_PATH/authserver_$(date +%Y%m%d_%H%M%S).log"
WORLD_LOG="$LOGS_PATH/worldserver_$(date +%Y%m%d_%H%M%S).log"
WORLD_CRASH_LOG="$CRASHES_PATH/worldserver_gdb_$(date +%Y%m%d_%H%M%S).log"

##########################################################################################
# Start authserver
##########################################################################################
AUTH_CMD="${SERVER_ROOT}/acore.sh run-authserver"
start_tmux_session "$AUTHSERVER_SESSION" "$AUTH_CMD" "$AUTH_LOG"

##########################################################################################
# Start worldserver
##########################################################################################
if [[ $DEBUG_MODE -eq 1 ]]; then
    echo "DEBUG MODE: Running worldserver under GDB"
    WORLD_CMD="gdb -ex 'set logging file $WORLD_CRASH_LOG' \
