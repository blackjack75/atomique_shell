#!/usr/bin/env bash


# Check if a window with the specified name exists
if tmux list-windows | grep -q "atomique-menu"; then
    tmux select-window -t "atomique-menu"
else
    aamenu 
    
    #tmux new-window -n "atomique-menu" "$SHELL --login -i -c 'aamenu'"
fi


