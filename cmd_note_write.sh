#!/usr/bin/env bash   


#title="Select Note to Edit"

export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

source "$SCRIPT_DIR/inc_decoration.sh"

# Rename the window
tmux rename-window "atomique-note-write"

folder=$(realpath ~/atomique/data/notes/dump/)
prefix="dump"

i=1
while [[ -e "$folder/$prefix$i.txt" ]]; do
        
      	((i++))
done

nfile="$folder/$prefix$i.txt"

$EDITOR "$nfile"

# Set tmux window name to default (empty string)
tmux rename-window "atomique-note-edition-ended"

