#!/usr/bin/env bash   
 
# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$SCRIPT_DIR" ]
then
        export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi
tmux rename-window "atomique-ssh-read-key"

title="Pick a public key to copy to clipboard "


export FOLDER=~/.ssh
export FILTER=*.pub

source "$SCRIPT_DIR/inc/inc_select_file.sh"

export COPYME=$(cat $selected_file)
source "$SCRIPT_DIR/inc/inc_copy_clipboard.sh"

