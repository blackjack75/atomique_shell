#!/usr/bin/env bash   

export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
source "$SCRIPT_DIR/inc_decoration.sh"

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
title="ATOMIQUE.ORG"
export title


echo $TOPLINE
echo $title
echo $TOPLINE


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
	  --preview='echo {} | "$SCRIPT_DIR/inc_preview_menu.sh" ' \
	  --preview-window=up:6:wrap --exact 
)
fi

export selected_menu
source "$SCRIPT_DIR/inc_parse_line_menu.sh"

# Print chosen server's name
clear

echo $SEPLINE
echo " Running $menu_title - command: $menu_command"
echo $SEPLINE

if [ "$menu_command" = "kill" ]; then
    echo "It was good knowing you."
	exit 1
else

	"$SCRIPT_DIR/$menu_command"
        echo " "
	echo $SEPLINE
	echo " Command ended. Press any key to go back to atomique menu..."
        echo $SEPLINE
	read -n 1 -s

	"$SCRIPT_DIR/atomique_menu.sh"

fi
