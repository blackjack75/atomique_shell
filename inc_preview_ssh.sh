#!/usr/bin/env bash 

piped_input=""

# Read input line by line and append to the variable
while IFS= read -r line; do
    piped_input+="$line"
done

selected_server=$piped_input
export selected_server

# Define variables
source "$SCRIPT_DIR/inc_parse_line_ssh.sh"

echo "---------------------------------"
echo $title
echo "---------------------------------"

clean_name=$(echo "$server_name" | tr -cd '[:alnum:]_.-' | tr -s '_')-ssh

nbwin=$(tmux list-windows | grep -ci "$clean_name")

echo "Name: $server_name Active Windows: $nbwin   " 
echo "Host: $server_host   User: $server_user   Port: $server_port"
echo "Keywords: $server_keywords    " 


echo "---------------------------------"


