#!/usr/bin/env bash   

title="Select Windows Server to put to sleep"

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
source "$SCRIPT_DIR/inc_select_server.sh"

echo "Will force sleep this Windows Machine via OpenSSH ..."; 

ssh -p $server_port $server_host_and_user "shutdown /s /f /t 0"

