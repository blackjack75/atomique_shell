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
selected_file=$(
  cat $SERVERS_PATH/*.txt | \
	  fzy -i
)
else

	  
selected_file=$(
	
	rg -i -l --files-with-matches ''i \
	     	~/atomique/data/notes/**/*.txt \
		 | fzf --preview='cat {}  | "$SCRIPT_DIR/inc_preview_note.sh" ' \
		 --preview-window=up:20:wrap  
)
fi


# Print file name
clear

echo "-------------------------------------"
echo "Path : $selected_file "
echo "-------------------------------------"

export selected_file
