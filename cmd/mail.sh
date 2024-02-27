#!/usr/bin/env bash   
 
# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$ATOMIQUE_ROOT_DIR" ]
then
        export ATOMIQUE_ROOT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi


WIN_NAME="atomique-mail"

#AVOID SHOWING error for fast returning command
ALLOW_MENU_BACK_NOW=1

# ALWAYS REUSE SAME TMUX WINDOW
if ! tmux list-windows -F "#{window_name}" | grep -q "$WIN_NAME"; then
        tmux rename-window "$WIN_NAME"
        aerc
else
        
	tmux select-window -t "$WIN_NAME"

fi

