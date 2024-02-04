#!/usr/bin/env bash   

# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$SCRIPT_DIR" ]
then
        export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi

source "$SCRIPT_DIR/inc/inc_decoration.sh"

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



# Check if the status pane exists
tmux list-panes -F '#{pane_current_command}' | grep -q "check_changes.sh"

# If the pane does not exist, create it
if [ $? -ne 0 ]; then
    tmux split-window -l 4 -v -c '#{pane_current_path}' "$SCRIPT_DIR/cmd/check_changes.sh" \; select-pane -t:.0
fi


title="ATOMIQUE.ORG"
export title


echo $TOPLINE
echo $title
echo $TOPLINE


#--------------------------------------------------------------------
# FZY IS for Haiku or all plaforms without a recent Golang to get fzf
#--------------------------------------------------------------------
if [ "$FZF_CMD" == "fzy" ]; then

clear
lines=$(tput lines)
((lines -= 2))

selected_menu=$(
  cat "$SCRIPT_DIR/texts/atomique_menu_entries.txt" | \
	  fzy -i -l $lines
)
else

#--------------------------------------------------------------------
# FZF will filter elements and display preview
#--------------------------------------------------------------------
selected_menu=$(

  cat "$SCRIPT_DIR/texts/atomique_menu_entries.txt" | \
	  fzf --delimiter='|'  \
	  --preview='echo {} | "$SCRIPT_DIR/inc/inc_preview_menu.sh" ' \
	  --preview-window=up:6:wrap --exact 
)
fi

#kill status pane
tmux kill-pane -t 1

export selected_menu
source "$SCRIPT_DIR/inc/inc_parse_line_menu.sh"
date +%s > /tmp/atomique_time_test

clear
if [ "$menu_command" = "kill" ]; then
    tmux rename-window "atomique-exited"
    clear
    rm /tmp/atomique_time_test
    echo "It was good knowing you."
    exit 1
elif [ "$menu_command" = "" ]; then

	echo "No command. You picked an empty line I guess :-)"

else

start=$(date +%s.%N)
   
  if [[ $menu_command == *.sh ]]; then
     "$SCRIPT_DIR/cmd/$menu_command"
  else                                                                 
     "$menu_command"
  fi     

end=$(date +%s.%N)
duration=$(echo "$end - $start" | bc)

# Check if the duration is less than 2 seconds and print "hey" if so
minsec=2

  if (( $(echo "$duration < $minsec" | bc -l) )); then
        echo $SEPLINE
	echo " Ended $menu_title - command: [ $menu_command ]"
        echo $SEPLINE
        echo 
	echo " Command ended in under $minsec seconds."
        echo " Press any key to go back to atomique menu..."
        echo $SEPLINE
	read -n 1 -s
  fi
fi

"$SCRIPT_DIR/cmd/atomique_menu.sh"

