#!/usr/bin/env bash   
 

# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$ATOMIQUE_ROOT_DIR" ]
then
        export ATOMIQUE_ROOT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi
tmux rename-window "atomique-ssh-get-ip"

title="Pick a server to remove SSH key from known hosts and allow connecting after a key has changed"

source "$ATOMIQUE_ROOT_DIR/inc/inc_select_server.sh"


echo "Will remove host ::$server_host:: "

ssh-keygen -f "$HOME/.ssh/known_hosts" -R "$server_host"

read -n 1
