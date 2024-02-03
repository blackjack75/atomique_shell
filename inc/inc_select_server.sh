#!/usr/bin/env bash 

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

# title variable must be defined by parent script
if [ -z "$title" ]; then
    # If not defined, set it to a default value
    title="Select SSH Server"
fi

export title

SERVERS_PATH=~/atomique/data/servers

## Check if FZF_CMD is equal to fzy
if [ "$FZF_CMD" == "fzy" ]; then
selected_server=$(
clear
lines=$(tput lines)
((lines -= 2))

  cat $SERVERS_PATH/*.txt | \
	  fzy -i -l $lines
)
else

selected_server=$(

  cat $SERVERS_PATH/*.txt | \
	  fzf --delimiter='|'  \
	  --preview='echo {} | "$SCRIPT_DIR/inc/inc_preview_ssh.sh" ' \
	  --preview-window=up:6:wrap  
)
fi

source "$SCRIPT_DIR/inc/inc_parse_line_ssh.sh"

# Print chosen server's name
clear

echo "-------------------------------------"
echo "Picked : $server_name ( $server_user @ $server_host : $server_port ) "
echo "-------------------------------------"

