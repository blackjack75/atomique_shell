#!/usr/bin/env bash


# Check if a window with the specified name exists
if tmux list-windows | grep -q "atomique-menu"; then
    tmux select-window -t "atomique-menu"
else
    tmux new-window -n "atomique-menu" "$SHELL --login -i -c 'aamenu'"
fi

exit 0
