#!/usr/bin/env bash   

# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$ATOMIQUE_ROOT_DIR" ]
then
        export ATOMIQUE_ROOT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi

function cleanExit() {
    tmux rename-window "atomique-exited"
    clear
    rm /tmp/atomique_time_test
    # echo "It was good knowing you."
    exit 0
}

handle_ctrl_c() {
    echo "Caught Ctrl-C, running cleanup code..."
    cleanExit
}

# Trap the SIGINT signal (which is sent when you press Ctrl-C)
trap handle_ctrl_c SIGINT





WIN_NAME="atomique-menu"

ACTIVE_WINDOW=$(tmux display-message -p '#W')

#AVOID SHOWING error for fast returning command
ALLOW_MENU_BACK_NOW=1
GO_ON=0
#Switch to existing window with atomique menu
if [ "$ACTIVE_WINDOW" != "$WIN_NAME" ]; then
   if tmux list-windows -F "#{window_name}" | grep -q "$WIN_NAME"; then
        tmux select-window -t "$WIN_NAME" 
   else
   GO_ON=1
   fi
fi

if [ "$GO_ON" == "1" ]; then

tmux rename-window "$WIN_NAME"

source "$ATOMIQUE_ROOT_DIR/inc/inc_decoration.sh"

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


#Enable again check for short command error
ALLOW_MENU_BACK_NOW=777

# Check if the status pane exists
tmux list-panes -F '#{pane_current_command}' | grep -q "check_changes.sh"

# If the pane does not exist, create it
if [ $? -ne 0 ]; then
    tmux split-window -l 4 -v -c '#{pane_current_path}' "$ATOMIQUE_ROOT_DIR/cmd/check_changes.sh" \; select-pane -t:.0
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
  cat "$ATOMIQUE_ROOT_DIR/texts/atomique_menu_entries.txt" | \
	  fzy -i -l $lines
)
else

#--------------------------------------------------------------------
# FZF will filter elements and display preview
#--------------------------------------------------------------------
selected_menu=$(

  cat "$ATOMIQUE_ROOT_DIR/texts/atomique_menu_entries.txt" | \
	  fzf --delimiter='|'  \
	  --preview='echo {} | "$ATOMIQUE_ROOT_DIR/inc/inc_preview_menu.sh" ' \
	  --preview-window=up:6:wrap --exact 
)
fi

tmux rename-window "atomique-ready-to-execute"

#kill status pane
tmux kill-pane -t 1

export selected_menu
source "$ATOMIQUE_ROOT_DIR/inc/inc_parse_line_menu.sh"
date +%s > /tmp/atomique_time_test

clear
if [ "$menu_command" = "kill" ]; then

     cleanExit
   
elif [ "$menu_command" = "" ]; then

  cleanExit 
else

  start=$(date +%s.%N)
  
  #most commands will rename the window but in any case 
  #we need to change the window name otherwise calling the menu again 
  #would show this running command 
  tmux rename-window "atomique-generic-command"
   echo MMENU COMMAND $menu_command
  if [[ $menu_command == *.sh ]]; then
     "$ATOMIQUE_ROOT_DIR/cmd/$menu_command"
  else                                                                 
     "$menu_command"
  fi     

end=$(date +%s.%N)
duration=$(echo "$end - $start" | bc)

# Check if the duration is less than 2 seconds and print "hey" if so
minsec=2


  if (( $ALLOW_MENU_BACK_NOW==777)); then
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
fi

tmux rename-window "atomique-menu"

"$ATOMIQUE_ROOT_DIR/cmd/atomique_menu.sh"


fi
