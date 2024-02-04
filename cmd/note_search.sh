#!/usr/bin/env bash   

# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$SCRIPT_DIR" ]
then
        export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi

title="Select Note to Edit"


# Rename the window
tmux rename-window "atomique-note-search"

source "$SCRIPT_DIR/inc/inc_decoration.sh"
source "$SCRIPT_DIR/inc/inc_select_note.sh"



if [ -n "$selected_file" ]; then
vim  $selected_file
#$EDITOR $selected_file
fi

# Set tmux window name to default (empty string)
tmux rename-window "note edition ended"

