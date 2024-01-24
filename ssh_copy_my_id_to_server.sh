#!/usr/bin/env bash   
 
title="Select Server to copy your ECDSA key to"

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
source "$SCRIPT_DIR/inc_select_server.sh"

echo "Copying local id_ecdsa key  to this server ..."; 
ssh-copy-id -i ~/.ssh/id_ecdsa.pub -p $server_port $server_host_and_user 


