#!/usr/bin/env bash   

title="Select Note to Edit"

export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

source "$SCRIPT_DIR/inc_decoration.sh"
source "$SCRIPT_DIR/inc_select_note.sh"


# Rename the window
tmux rename-window "Note-search"

if [ -n "$selected_file" ]; then
$EDITOR $selected_file
fi

# Set tmux window name to default (empty string)
tmux rename-window "note edition ended"

