#!/usr/bin/env bash   
 
# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$ATOMIQUE_ROOT_DIR" ]
then
        export ATOMIQUE_ROOT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi


if tmux list-windows | grep -q "atomique-gpt"; then
    
    #make sure this goes back to menu
    tmux rename-window "atomique-menu"
    
    tmux select-window -t "atomique-gpt"
    exit 0

elsefif 

	
tmux rename-window "atomique-gpt"
#echo "Type 's' for shell-gpt or any other key for Elia:"
#read -r choice

#if [ "$choice" = "s" ]; then
#    echo "You chose sgpt"

tenere
fi
