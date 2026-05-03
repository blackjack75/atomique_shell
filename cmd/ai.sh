#!/usr/bin/env bash
 
# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$ATOMIQUE_ROOT_DIR" ]
then
        export ATOMIQUE_ROOT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi

THISWIN=atomique-ia-$1

if tmux list-windows | grep -q "$THISWIN"; then
    
    #make sure this goes back to menu
    tmux rename-window "atomique-menu"
    
    tmux select-window -t "$THISWIN"
    exit 0

else 

	
tmux rename-window "$THISWIN"

export OLLAMA_HOST="http://10.22.22.40:11434"
if [ $1 == "m4" ]; then
   export OLLAMA_HOST="http://192.168.0.120:11434"
fi
echo launching on $OLLAMA_HOST
lazyollama

fi
