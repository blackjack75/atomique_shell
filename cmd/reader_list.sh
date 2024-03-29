#!/usr/bin/env bash   

title="Pick URL to Read"

# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$var" ]
then
	export ATOMIQUE_ROOT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi
tmux rename-window "atomique-reader-list"

source "$ATOMIQUE_ROOT_DIR/inc/inc_decoration.sh"

export title="Select URL to read"
source "$ATOMIQUE_ROOT_DIR/inc/inc_select_url.sh"

# Rename the window
clean_name=$(echo "$domain_name" | tr -cd '[:alnum:]_.-' | tr -s '_')-reader

echo $SEPLINE
if [ "$url" = "" ]; then
	echo "No server selected. You picked an empty line I guess :-)"
else

   source "$ATOMIQUE_ROOT_DIR/cmd/reader_get.sh"

   #back fo list after reading
   source "$ATOMIQUE_ROOT_DIR/cmd/reader_list.sh"

	
fi
