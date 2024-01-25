#!/usr/bin/env bash   

title="Select Server to connect to"


export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

source "$SCRIPT_DIR/inc_decoration.sh"
source "$SCRIPT_DIR/inc_select_server.sh"


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
statusInfo="$server_host_and_user"
tmux split-window -l 4 -v -c '#{pane_current_path}' "while true; do $SCRIPT_DIR/inc_status_ssh.sh \"$statusInfo\" ; sleep 1; done" \; select-pane -t:.0

cmd="tmux new-session -A -s \"$remoteName\""
cmdMac="source ~/.zshrc;tmux new-session -A -s \"$remoteName\""
cmdWin=

echo $SEPLINE
if [ "$server_host_and_user" = "" ]; then
	echo "No server selected. You picked an empty line I guess :-)"
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

	"$SCRIPT_DIR/cmd_ssh_connect.sh"

fi
