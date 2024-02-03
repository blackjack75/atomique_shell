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
    echo 5
    exit 1

fi

# title variable must be defined by parent script
if [ -z "$title" ]; then
    # If not defined, set it to a default value
    title="Select SSH Server"
fi

export title

DIR=~/atomique/data/notes/

## Check if FZF_CMD is equal to fzy
if [ "$FZF_CMD" == "fzy" ]; then

clear
lines=$(tput lines)
((lines -= 2))

selected_file=$(
echo "NO WAY THIS CAN WORK with fzy"
fzy -i -l $lines
)
else

# 1. Search for text in files using Ripgrep
# 2. Interactively narrow down the list using fzf
# 3. Open the file in Vim
#
cd $DIR

IFS=: read -ra selected < <(
  rg --color=always --line-number --no-heading --smart-case "${*:-}" . |
    fzf --ansi \
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'
)
[ -n "${selected[0]}" ] 

# We can get both the file and positions (not used right now)
#&& vim "${selected[0]}" "+${selected[1]}"

selected_file=${selected[0]}

fi

clear

echo "-------------------------------------"
echo "Path : $selected_file "
echo "-------------------------------------"

export selected_file
