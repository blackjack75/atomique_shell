#!/usr/bin/env bash


# Check if a window with the specified name exists
if tmux list-windows | grep -q "atomique-menu"; then
    tmux select-window -t "atomique-menu"


        # If "aamenu" is not running, launch it
#        tmux send-keys -t "atomique-menu" "aamenu" Enter


else
#Don't launch shell twice 
if [[ -n "$EDITOR" ]]; then
    tmux new-window -n "atomique-menu" $HOME/atomique/code/atomique_shell/bin/aamenu
else
    tmux new-window -n "atomique-menu" "$SHELL --login -i -c 'aamenu'"
fi

fi

