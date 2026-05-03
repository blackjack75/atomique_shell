#!/usr/bin/env bash
 
# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$ATOMIQUE_ROOT_DIR" ]
then
        export ATOMIQUE_ROOT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi

THISWIN=atomique-ia

if tmux list-windows | grep -q "$THISWIN"; then
    
    #make sure this goes back to menu
    tmux rename-window "atomique-menu"
    
    tmux select-window -t "$THISWIN"
    exit 0

else 

	
tmux rename-window "$THISWIN"

OLLAMA_HOST=http://194.168.0.120:11434
lazyollama
fi
