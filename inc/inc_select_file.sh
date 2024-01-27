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
    title="Select File"
fi

export title

#FOLDER=~/.ssh
#FILTER=*.pub

## Check if FZF_CMD is equal to fzy
if [ "$FZF_CMD" == "fzy" ]; then
selected_file=$(
  find $FOLDER -type f -name "$FILTER" \
	  fzy -i
)
else

selected_file=$(

  find $FOLDER -type f -name "$FILTER" \
	  | fzf --preview='echo {} | "$SCRIPT_DIR/inc/inc_preview_file.sh" ' \
	  --preview-window=up:6:wrap  
)
fi

# Print chosen filename
clear

echo "-------------------------------------"
echo "Picked : $selected_file "
echo "-------------------------------------"

