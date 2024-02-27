#!/usr/bin/env bash   

# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$var" ]
then
	export ATOMIQUE_ROOT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi


#This same name is set in tmux.conf, don't change it but make sure to restore it

WIN_NAME="atomique-ssh-selector"

ACTIVE_WINDOW=$(tmux display-message -p '#W')

#AVOID SHOWING error for fast returning command
ALLOW_MENU_BACK_NOW=1

#Switch to existing window with atomique menu
if [ "$ACTIVE_WINDOW" != "$WIN_NAME" ]; then
   if tmux list-windows -F "#{window_name}" | grep -q "$WIN_NAME"; then
        tmux select-window -t "$WIN_NAME" 
   fi
else

tmux rename-window "$WIN_NAME"

title="Select Server to connect to"


source "$ATOMIQUE_ROOT_DIR/inc/inc_decoration.sh"
source "$ATOMIQUE_ROOT_DIR/inc/inc_select_server.sh"

# Rename the window
# they are reused if connecting from another machine
# but here with a nested tmux i prefer 1 session per window
clean_name=$(echo "$server_name" | tr -cd '[:alnum:]_.-' | tr -s '_')-ssh
nbwin=$(tmux list-windows | grep -ci "$clean_name")
tmux rename-window "$clean_name-$nbwin"


remoteName="fromSSH-$nbwin"
# Connect to the chosen server using its IP address (second field)

#Create STATUS pane
statusInfo="$server_name $server_host_and_user : $server_port"
tmux split-window -l 2 -v -c '#{pane_current_path}' "$ATOMIQUE_ROOT_DIR/inc/inc_status_ssh.sh \"$statusInfo\" " \; select-pane -t:.0


tmuxpath=tmux
#Intel Mac, force different path for tmux, otherwise it is not found
if [[ $(echo "$server_keywords" | grep -i "macintosh" | grep -i "intel") ]]; then
    tmuxpath=/usr/local/bin/tmux
fi

cmd="tmux new-session -A -s \"$remoteName\""
cmdMac="source ~/.zshrc;$tmuxpath new-session -A -s \"$remoteName\""
cmdWin=


# some servers (such as lema.org fails with tmux-256-colors
# this works on more platforms
export TERM=screen-256color   

echo $SEPLINE
if [ "$server_host_and_user" = "" ]; then
	echo "No server selected. You picked an empty line I guess :-)"
	#kill status pane
	tmux kill-pane -t 1
else

if [[ $(echo "$server_keywords" | grep -i "macintosh") ]]; 
  then 
	  echo "Connecting to a Mac..."; 
	  ssh -p $server_port -t $server_host_and_user $cmdMac;

elif [[ $(echo "$server_keywords" | grep -i "windows") ]]; 
  then 
	  echo "Connecting to Windows OpenSSH"; 
          ssh -p $server_port -t $server_host_and_user $cmdWin;
  else
	  echo "Connecting to Server..."; 
          ssh -p $server_port -t $server_host_and_user $cmd;
fi


	# Set tmux window name to default (empty string)
        tmux rename-window "disconnected from ssh"


        echo 
	echo $SEPLINE

	echo " SSH Command ended. Press any key to go back to atomique SSH menu..."
        echo $SEPLINE
	read -n 1 -s

	
        #restore name otherwise it will keep old session name	
	tmux rename-window "atomique-ssh-selector"
	
	#kill status pane
	tmux kill-pane -t 1

	"$ATOMIQUE_ROOT_DIR/cmd/ssh_connect.sh"
fi


fi
