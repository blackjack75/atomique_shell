#!/usr/bin/env bash   
 

# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$SCRIPT_DIR" ]
then
        export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi


title="Pick a server to print IP and copy to clipboard "

source "$SCRIPT_DIR/inc/inc_select_server.sh"

export COPYME=$server_host
source "$SCRIPT_DIR/inc/inc_copy_clipboard.sh"


