#!/usr/bin/env bash   
 
title="Pick a server to PING"


# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$SCRIPT_DIR" ]
then
        export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi

tmux rename-window "atomique-ping-server"

source "$SCRIPT_DIR/inc/inc_select_server.sh"

echo "Server is $server_host"

#we want gping to close pane on first control-c 
# so it sends another control c to first pane then exits


tmux split-window -v -p 70  "gping $server_host && exit 0"
tmux split-window -v -l 2  "export message=\"PING $server_name ($server_host)\" && source \"$SCRIPT_DIR/inc/inc_message_and_wait.sh\" && tmux send-keys -t 0 C-c C-c && tmux send-keys -t 1 C-c && exit" 


#tmux send-keys -t 1 "gping $server_host && exit 0" C-m
#tmux send-keys -t 2 "export message=\"PING $server_name ($server_host)\" && source \"$SCRIPT_DIR/inc/inc_message_and_wait.sh\" && tmux send-keys -t 0 C-c C-c && tmux send-keys -t 1 C-c && exit" C-m



ping $server_host  && exit 0
