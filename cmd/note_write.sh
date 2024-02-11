#!/usr/bin/env bash   

# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$SCRIPT_DIR" ]
then
        export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi


#title="Select Note to Edit"

source "$SCRIPT_DIR/inc/inc_decoration.sh"

# Rename the window
tmux rename-window "atomique-note-write"

folder=$(realpath ~/atomique/data/notes/dump/)
prefix="dump"

i=1
while [[ -e "$folder/$prefix$i.md" ]]; do
      	((i++))
done

nfile="$folder/$prefix$i.md"

#echo "will open in editor: [ $EDITOR ] file $nfile"
$EDITOR "$nfile"

# Set tmux window name to default (empty string)
tmux rename-window "atomique-note-edition-ended"

