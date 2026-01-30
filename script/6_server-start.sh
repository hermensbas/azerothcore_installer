#!/bin/bash

##########################################################################################
# Paths for logs and crash dumps
##########################################################################################
export LOGS_PATH="/tmp/ac/logs"
export CRASHES_PATH="/tmp/ac/crashes"
rm -rf "$LOGS_PATH" "$CRASHES_PATH"
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
GDB_LOG="$CRASHES_PATH/worldserver_gdb_$TIMESTAMP.log"

##########################################################################################
# Determine SERVER_ROOT based on script location (works with aliases)
##########################################################################################
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

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

    # If session exists, attach and return
    if tmux has-session -t "$session_name" 2>/dev/null; then
        echo "Tmux session '$session_name' already exists. Attaching..."
        tmux attach-session -t "$session_name"
        return 0
    fi

    # Create new session
    if tmux new-session -d -s "$session_name"; then
        echo "Created tmux session: $session_name"
    else
        echo "Error creating tmux session: $session_name"
        return 1
    fi

    # Export environment variables inside tmux
    tmux send-keys -t "$session_name" "export LOGS_PATH=$LOGS_PATH; export CRASHES_PATH=$CRASHES_PATH" C-m
    
    # Run the command and pipe output to a log file
    tmux send-keys -t "$session_name" "$command" C-m

    echo "Running '$command' in $session_name"
    echo
}

##########################################################################################
# Prepare commands
##########################################################################################

# Authserver via acore.sh for auto-restart
AUTH_CMD="${ROOT}/_server/azerothcore/acore.sh run-authserver"

# Worldserver
if [[ $DEBUG_MODE -eq 1 ]]; then

    #  via GDB with RelWithDebInfo or Debug build (debuginfod downloads missing symbols real-time)
    echo "DEBUG MODE: Running worldserver under GDB"
    WORLD_CMD="cd $ROOT/_server/azerothcore/env/dist/bin && \
        gdb \
          -ex \"set logging file $GDB_LOG\" \
          -ex \"set debuginfod enabled on\" \
          -ex \"set logging on\" \
          -ex \"set pagination off\" \
          -ex \"set confirm off\" \
          -ex \"set print pretty on\" \
          -ex \"set print elements 0\" \
          -ex \"set print object on\" \
          -ex \"handle SIGSEGV stop print pass\" \
          -ex \"handle SIGABRT stop print pass\" \
          -ex \"handle SIGFPE stop print pass\" \
          -ex \"handle SIGILL stop print pass\" \
          -ex \"define hook-stop\" \
          -ex \"bt full\" \
          -ex \"thread apply all bt\" \
          -ex \"end\" \
          --args ./worldserver -c ../etc/worldserver.conf"
else

    # via acore.sh for auto-restart
    WORLD_CMD="$ROOT/_server/azerothcore/acore.sh run-worldserver"
fi

##########################################################################################
# Start servers
##########################################################################################
start_tmux_session "$AUTHSERVER_SESSION" "$AUTH_CMD"
start_tmux_session "$WORLDSERVER_SESSION" "$WORLD_CMD"

##########################################################################################
# Optional: show menu if exists
##########################################################################################
if [[ -f "${ROOT}/script/menu.sh" ]]; then
    source "${ROOT}/script/menu.sh"
fi
