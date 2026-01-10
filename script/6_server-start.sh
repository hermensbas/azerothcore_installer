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

# Timestamps for log files
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
AUTH_LOG="$LOGS_PATH/authserver_$TIMESTAMP.log"
WORLD_LOG="$LOGS_PATH/worldserver_$TIMESTAMP.log"
WORLD_CRASH_LOG="$CRASHES_PATH/worldserver_gdb_$TIMESTAMP.log"

##########################################################################################
# Determine SERVER_ROOT based on script location (works with aliases)
##########################################################################################
SERVER_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

RUN_ENGINE="$SERVER_ROOT/_server/azerothcore/apps/startup-scripts/src/run-engine"

##########################################################################################
# Check debug toggle
##########################################################################################
DEBUG_MODE=0
if [[ "$1" == "debug" ]]; then
    DEBUG_MODE=1
fi

##########################################################################################
# Helper to start a tmux session
##########################################################################################
start_tmux_session() {
    local session_name=$1
    local command=$2
    local log_file=$3

    # Create session if it doesn't exist
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

    # Export environment variables inside tmux
    tmux send-keys -t "$session_name" "export LOGS_PATH=$LOGS_PATH; export CRASHES_PATH=$CRASHES_PATH" C-m

    # Run the command and pipe output to a new log file
    tmux send-keys -t "$session_name" "$command | tee $log_file" C-m

    echo "Running '$command' in $session_name, logging to $log_file"
    echo
}

##########################################################################################
# Prepare commands
##########################################################################################

# Authserver always via acore.sh for auto-restart
AUTH_CMD="${SERVER_ROOT}/acore.sh run-authserver"

if [[ $DEBUG_MODE -eq 1 ]]; then
    echo "DEBUG MODE: Running worldserver under GDB"
    WORLD_CMD="$RUN_ENGINE restart worldserver \
        --bin-path ${SERVER_ROOT}/env/dist/bin \
        --server-config ${SERVER_ROOT}/conf/worldserver.conf \
        --session-manager tmux \
        --gdb-enabled 1 \
        --logs-path $LOGS_PATH \
        --crashes-path $CRASHES_PATH"
else
    WORLD_CMD="$RUN_ENGINE restart worldserver \
        --bin-path ${SERVER_ROOT}/env/dist/bin \
        --server-config ${SERVER_ROOT}/conf/worldserver.conf \
        --session-manager tmux \
        --logs-path $LOGS_PATH \
        --crashes-path $CRASHES_PATH"
fi

##########################################################################################
# Start servers
##########################################################################################
start_tmux_session "$AUTHSERVER_SESSION" "$AUTH_CMD" "$AUTH_LOG"
start_tmux_session "$WORLDSERVER_SESSION" "$WORLD_CMD" "$WORLD_LOG"

##########################################################################################
# Optional: show menu if exists
##########################################################################################
if [[ -f "${SERVER_ROOT}/script/menu.sh" ]]; then
    source "${SERVER_ROOT}/script/menu.sh"
fi
