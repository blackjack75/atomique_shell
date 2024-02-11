#!/usr/bin/env bash   
 
# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$ATOMIQUE_ROOT_DIR" ]
then
        export ATOMIQUE_ROOT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi
tmux rename-window "atomique-ssh-copy-id"
title="Select Server to copy your ECDSA key to"

source "$ATOMIQUE_ROOT_DIR/inc/inc_select_server.sh"

echo "Copying local id_ecdsa key  to this server ..."; 
ssh-copy-id -i ~/.ssh/id_ecdsa.pub -p $server_port $server_host_and_user 

read -n 1
