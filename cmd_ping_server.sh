#!/usr/bin/env bash   
 
title="Pick a server to PING"

export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
source "$SCRIPT_DIR/inc_select_server.sh"

echo "Server is $server_host"

#we want gping to close pane on first control-c 
# so it sends another control c to first pane then exits
tmux split-window -v
tmux send-keys -t 1 "gping $server_host && exit  " C-m

tmux split-window -v -l 3
tmux send-keys -t 1 "echo \"PINGING $server_name ( $server_host )\" i && read -n 1 -s key &&  tmux send-keys -t 0 C-c tmux send-keys -t 1 C-c && exit  " C-m

ping $server_host  

