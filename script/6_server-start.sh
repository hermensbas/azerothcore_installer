#!/bin/bash

##########################################################################################
# Paths for logs and crash dumps
##########################################################################################
export LOGS_PATH="/tmp/ac/logs"
export CRASHES_PATH="/tmp/ac/crashes"

mkdir -p "$LOGS_PATH" "$CRASHES_PATH"

##########################################################################################
# Helper to start a tmux session and run a command
##########################################################################################
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

    # Export environment variables inside tmux
    tmux send-keys -t "$session_name" "export LOGS_PATH=$LOGS_PATH; export CRASHES_PATH=$CRASHES_PATH" C-m

    # Run the command and pipe output to a log file
    tmux send-keys -t "$session_name" "$command | tee -a $log_file" C-m

    echo "Executed '$command' inside $session_name, logging to $log_file"
    echo
}

##########################################################################################
# Start authserver normally in tmux
##########################################################################################
start_tmux_session "$AUTHSERVER_SESSION" "${SERVER_ROOT}/acore.sh run-authserver" "$LOGS_PATH/authserver.log"

##########################################################################################
# Start worldserver under tmux + GDB for crash logging
##########################################################################################
WORLDSESSION="$WORLDSERVER_SESSION"
WORLD_CRASH_LOG="$CRASHES_PATH/worldserver_gdb.log"

# Remove old crash log
[ -f "$WORLD_CRASH_LOG" ] && rm -f "$WORLD_CRASH_LOG"

# Create worldserver tmux session if needed
if tmux has-session -t "$WORLDSESSION" 2>/dev/null; then
    echo "Tmux session '$WORLDSESSION' already exists."
else
    if tmux new-session -d -s "$WORLDSESSION"; then
        echo "Created tmux session: $WORLDSESSION"
    else
        echo "Error creating tmux session: $WORLDSESSION"
        exit 1
    fi
fi

# Command to run worldserver under gdb in tmux
WORLD_CMD="gdb -ex 'set logging file $WORLD_CRASH_LOG' \
    -ex 'set logging on' \
    -ex 'run' \
    -ex 'bt full' \
    -ex 'quit' \
    --args ${SERVER_ROOT}/acore.sh run-worldserver"

# Export env + run GDB inside tmux
tmux send-keys -t "$WORLDSESSION" "export LOGS_PATH=$LOGS_PATH; export CRASHES_PATH=$CRASHES_PATH" C-m
tmux send-keys -t "$WORLDSESSION" "$WORLD_CMD" C-m

echo "Worldserver started in tmux session '$WORLDSESSION' with GDB crash logging to $WORLD_CRASH_LOG."
echo "Attach to tmux to see live output: tmux attach -t $WORLDSESSION"

##########################################################################################
# Launch interactive menu if needed
##########################################################################################
source "${ROOT_DIR}/script/menu.sh"
