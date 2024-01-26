#!/usr/bin/env bash   
 
title="Pick a public key to copy to clipboard "


export FOLDER=~/.ssh
export FILTER=*.pub

export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
source "$SCRIPT_DIR/inc_select_file.sh"

export COPYME=$(cat $selected_file)
source "$SCRIPT_DIR/inc_copy_clipboard.sh"

