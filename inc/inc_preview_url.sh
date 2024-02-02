#!/usr/bin/env bash 

piped_input=""

# Read input line by line and append to the variable
while IFS= read -r line; do
    piped_input+="$line"
done

url=$piped_input
export url

# Define variables
#source "$SCRIPT_DIR/inc/inc_parse_line_ssh.sh"

echo $SEPLINE
echo " $title "
echo $SEPLINE

#clean_name=$(echo "$server_name" | tr -cd '[:alnum:]_.-' | tr -s '_')-ssh

nbwin=$(tmux list-windows | grep -ci "$clean_name")

echo "URL: $url"

echo $SEPLINE

