#!/usr/bin/env bash   

title="Select Windows Server to put to sleep"

source "$(dirname "${BASH_SOURCE[0]}")/includes/ssh_select_server.sh"

# Connect to the chosen server using its IP address (second field)


echo "Will force sleep this Windows Machine via OpenSSH ..."; 

ssh -p $server_port $server_host_and_user "shutdown /s /f /t 0"

