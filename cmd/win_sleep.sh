#!/usr/bin/env bash   

# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$ATOMIQUE_ROOT_DIR" ]
then
        export ATOMIQUE_ROOT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi

tmux rename-window "atomique-ssh-winsleep"

title="Select Windows Server to put to sleep"

source "$ATOMIQUE_ROOT_DIR/inc/inc_select_server.sh"

echo "Will force sleep this Windows Machine via OpenSSH ..."; 

ssh -p $server_port $server_host_and_user "shutdown /s /f /t 0"
read -n 1
