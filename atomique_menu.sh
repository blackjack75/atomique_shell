#!/usr/bin/env bash   

export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

tmux rename-window "atomique-menu"

## Check if fzf command is in the PATH
if command -v fzf &> /dev/null; then
    FZF_CMD="fzf"
    else
    FZF_CMD="fzy"
fi

# Check if fzf is installed
if ! command -v $FZF_CMD &> /dev/null
then
    echo "fzf or fzy is not installed. Please install one to continue." 
    exit 1
fi

clear
title=" ATOMIQUE.ORG - SELECT FEATURE"
export title


echo "--------------------------------------------"
echo $title
echo "--------------------------------------------"


#--------------------------------------------------------------------
# FZY IS for Haiku or all plaforms without a recent Golang to get fzf
#--------------------------------------------------------------------
if [ "$FZF_CMD" == "fzy" ]; then
selected_menu=$(
  cat "$SCRIPT_DIR/atomique_menu_entries.txt" | \
	  fzy -i
)
else

#--------------------------------------------------------------------
# FZF will filter elements and display preview
#--------------------------------------------------------------------
selected_menu=$(

  cat "$SCRIPT_DIR/atomique_menu_entries.txt" | \
	  fzf --delimiter='|'  \
	  --preview='echo {} | $SCRIPT_DIR/inc_preview_menu.sh ' \
	  --preview-window=up:6:wrap
)
fi

export selected_menu

source "$SCRIPT_DIR/inc_parse_line_menu.sh"

# Print chosen server's name
clear

echo "-------------------------------------"
echo " Running $menu_title - command: $menu_command"
echo "-------------------------------------"

"$SCRIPT_DIR/$menu_command"

