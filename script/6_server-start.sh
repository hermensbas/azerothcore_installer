#!/bin/bash

##########################################################################################
# Paths for logs and crash dumps
##########################################################################################
export LOGS_PATH="/tmp/ac/logs"
export CRASHES_PATH="/tmp/ac/crashes"

# Ensure directories exist
mkdir -p "$LOGS_PATH" "$CRASHES_PATH"

##########################################################################################
# handle the tmux sessions
##########################################################################################

# Helper to start a tmux session and run a command
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

    # Export environment variables inside tmux
    tmux send-keys -t "$session_name" "export LOGS_PATH=$LOGS_PATH; export CRASHES_PATH=$CRASHES_PATH" C-m

    # Run the command and pipe output to a log file
    tmux send-keys -t "$session_name" "$command | tee -a $log_file" C-m

    echo "Executed '$command' inside $session_name, logging to $log_file"
    echo
}

# Start authserver
start_tmux_session "$AUTHSERVER_SESSION" "${SERVER_ROOT}/acore.sh run-authserver" "$LOGS_PATH/authserver.log"

# Start worldserver
start_tmux_session "$WORLDSERVER_SESSION" "${SERVER_ROOT}/acore.sh run-worldserver" "$LOGS_PATH/worldserver.log"

##########################################################################################
# Launch interactive menu if needed
##########################################################################################
source "${ROOT_DIR}/script/menu.sh"
