#!/usr/bin/env bash   
 
title="Select Server to copy your ECDSA key to"
source "$(dirname "${BASH_SOURCE[0]}")/includes/ssh_select_server.sh"

# Connect to the chosen server using its IP address (second field)


echo "Copying local id_ecdsa key  to this server ..."; 
ssh-copy-id -i ~/.ssh/id_ecdsa.pub -p $server_port $server_host_and_user 


