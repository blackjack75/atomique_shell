#!/usr/bin/env bash   

title="Select Server to connect to"


SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
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

cmd="tmux new-session -A -s \"$remoteName\""
cmdMac="source ~/.zshrc;tmux new-session -A -s \"$remoteName\""
cmdWin=

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
