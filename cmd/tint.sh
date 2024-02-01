#!/usr/bin/env bash   
 
# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$SCRIPT_DIR" ]
then
        export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi

clear
tmux rename-window "atomique-tint"
tint -l 1
most -wd "$SCRIPT_DIR/texts/tetris_documentation.txt" 
