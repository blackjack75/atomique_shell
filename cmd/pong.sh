#!/usr/bin/env bash   
 
# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$ATOMIQUE_ROOT_DIR" ]
then
        export ATOMIQUE_ROOT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi

clear
tmux rename-window "atomique-pong"
~/repos/Pong/pong
