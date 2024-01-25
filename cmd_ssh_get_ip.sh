#!/usr/bin/env bash   
 
title="Pick a server to print IP and copy to clipboard "

export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
source "$SCRIPT_DIR/inc_select_server.sh"

export COPYME=$server_host
source "$SCRIPT_DIR/inc_copy_clipboard.sh"


