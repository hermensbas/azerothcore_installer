#!/bin/bash
##########################################################################################
# AzerothCore Server Start Script
# - Normal mode: runs via acore.sh (auto-restart, normal logs)
# - Debug mode: runs worldserver under GDB (no auto-restart, crash logs)
##########################################################################################

# ===============================
# Configuration
# ===============================
ROOT_DIR="/home/dev/azerothcore_installer"
SERVER_ROOT="$ROOT_DIR/_server/azerothcore"

AUTHSERVER_SESSION="auth-session"
WORLDSERVER_SESSION="world-session"

LOGS_PATH="/tmp/ac/logs"
CRASHES_PATH="/tmp/ac/crashes"

mkdir -p "$LOGS_PATH" "$CRASHES_PATH"

# Timestamp for log files
NOW=$(date +"%Y%m%d_%H%M%S")
AUTH_LOG="$LOGS_PATH/authserver_$NOW.log"
WORLD_LOG="$LOGS_PATH/worldserver_$NOW.log"
GDB_LOG="$CRASHES_PATH/worldserver_gdb_$NOW.log"

# Check for debug mode
DEBUG_MODE=0
if [[ "$1" == "debug" ]]; then
    DEBUG_MODE=1
    echo "DEBUG MODE: worldserver will run under GDB"
fi

# ===============================
# Helper: start tmux session
# ===============================
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

    # Run the command in tmux, output redirected to log file (overwrite)
    tmux send-keys -t "$session_name" "$command >$log_file 2>&1" C-m

    echo "Running '$command' inside $session_name, logging to $log_file"
    echo
}

# ===============================
# Start Authserver
# ===============================
AUTH_CMD="$SERVER_ROOT/acore.sh run-authserver"
start_tmux_session "$AUTHSERVER_SESSION" "$AUTH_CMD" "$AUTH_LOG"

# ===============================
# Start Worldserver
# ===============================
if [[ $DEBUG_MODE -eq 1 ]]; then
    WORLD_CMD="gdb -ex 'set logging file $GDB_LOG' \
                  -ex 'set logging enabled on' \
                  -ex 'run' \
                  -ex 'bt full' \
                  -ex 'quit' \
                  --args $SERVER_ROOT/env/dist/bin/worldserver"
else
    WORLD_CMD="$SERVER_ROOT/acore.sh run-worldserver"
fi

start_tmux_session "$WORLDSERVER_SESSION" "$WORLD_CMD" "$WORLD_LOG"

# ===============================
# Launch menu
# ===============================
if [[ -f "$ROOT_DIR/script/menu.sh" ]]; then
    source "$ROOT_DIR/script/menu.sh"
else
    echo "WARNING: menu.sh not found at $ROOT_DIR/script/menu.sh"
fi

echo "Server start script finished."
[[ $DEBUG_MODE -eq 1 ]] && echo "DEBUG: worldserver GDB log: $GDB_LOG"
