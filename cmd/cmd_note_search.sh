#!/usr/bin/env bash   

# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$SCRIPT_DIR" ]
then
        export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi

title="Select Note to Edit"


source "$SCRIPT_DIR/inc/inc_decoration.sh"
source "$SCRIPT_DIR/inc/inc_select_note.sh"


# Rename the window
tmux rename-window "Note-search"

if [ -n "$selected_file" ]; then
$EDITOR $selected_file
fi

# Set tmux window name to default (empty string)
tmux rename-window "note edition ended"

