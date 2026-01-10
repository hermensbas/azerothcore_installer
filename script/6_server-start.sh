#!/bin/bash

#./script.sh          # normal mode
#./script.sh debug    # debug mode (GDB, timestamped crash logs)

##########################################################################################
# Toggle debug mode
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
# Helper: start tmux session and run command
##########################################################################################
start_tmux_session() {
    local session_name=$1
    local command=$2
    local log_file=$3
    local debug=$4

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

    if [[ "$debug" -eq 1 ]]; then
        # Timestamped GDB log
        local gdb_log="$CRASHES_PATH/${session_name}_gdb_$(date +%Y%m%d_%H%M%S).log"
        tmux send-keys -t "$session_name" "gdb -ex 'set logging file $gdb_log' -ex 'set logging enabled on' -ex 'run' -ex 'bt full' -ex 'quit' --args $command" C-m
        echo "Debug mode enabled for $session_name, logging to $gdb_log"
    else
        # Normal mode: append output to log
        tmux send-keys -t "$session_name" "$command | tee -a $log_file" C-m
        echo "Executed '$command' inside $session_name, logging to $log_file"
    fi
    echo
}

##########################################################################################
# Start servers
##########################################################################################
# Authserver (no debug)
start_tmux_session "$AUTHSERVER_SESSION" "${SERVER_ROOT}/acore.sh run-authserver" "$LOGS_PATH/authserver.log" 0

# Worldserver (toggle debug)
start_tmux_session "$WORLDSERVER_SESSION" "${SERVER_ROOT}/acore.sh run-worldserver" "$LOGS_PATH/worldserver.log" $DEBUG_MODE

##########################################################################################
# Launch interactive menu if needed
##########################################################################################
source "${ROOT_DIR}/script/menu.sh"
