#!/usr/bin/env bash   

title="Select Server to connect to"

# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$var" ]
then
	export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi

source "$SCRIPT_DIR/inc/inc_decoration.sh"
source "$SCRIPT_DIR/inc/inc_select_server.sh"

# Rename the window
clean_name=$(echo "$server_name" | tr -cd '[:alnum:]_.-' | tr -s '_')-ssh

nbwin=$(tmux list-windows | grep -ci "$clean_name")

# We want a different name per session created here
# they are reused if connecting from another machine
# but here with a nested tmux i prefer 1 session per window
tmux rename-window "$clean_name-$nbwin"
remoteName="fromSSH-$nbwin"
# Connect to the chosen server using its IP address (second field)

#Create STATUS pane
statusInfo="$server_name $server_host_and_user : $server_port"
tmux split-window -l 2 -v -c '#{pane_current_path}' "$SCRIPT_DIR/inc/inc_status_ssh.sh \"$statusInfo\" " \; select-pane -t:.0

cmd="tmux new-session -A -s \"$remoteName\""
cmdMac="source ~/.zshrc;tmux new-session -A -s \"$remoteName\""
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

	#kill status pane
	tmux kill-pane -t 1

        echo 
	echo $SEPLINE

	echo " SSH Command ended. Press any key to go back to atomique SSH menu..."
        echo $SEPLINE
	read -n 1 -s

	"$SCRIPT_DIR/cmd/ssh_connect.sh"

fi
