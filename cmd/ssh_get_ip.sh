#!/usr/bin/env bash   
 

# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$ATOMIQUE_ROOT_DIR" ]
then
        export ATOMIQUE_ROOT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi
tmux rename-window "atomique-ssh-get-ip"

title="Pick a server to print IP and copy to clipboard "

source "$ATOMIQUE_ROOT_DIR/inc/inc_select_server.sh"

export COPYME=$server_host
source "$ATOMIQUE_ROOT_DIR/inc/inc_copy_clipboard.sh"

read -n 1
