#!/usr/bin/env bash   
 
# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$ATOMIQUE_ROOT_DIR" ]
then
        export ATOMIQUE_ROOT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi


if tmux list-windows | grep -q "atomique-gpt"; then
    
    #make sure this goes back to menu
    tmux rename-window "atomique-menu"
    
    tmux select-window -t "atomique-gpt"
    echo "will auto close in 3 sec"
    sleep 3
else

	
	
tmux rename-window "atomique-gpt"
echo "Type 's' for shell-gpt or any other key for Elia:"
read -r choice

if [ "$choice" = "s" ]; then
    echo "You chose sgpt"

clear
echo $SEPLINE
echo "Enter Conversation name or ENTER to pick existing: " 
echo $SEPLINE

read -p "Name: " userInput

if [ -n "$userInput" ]; then
       filename=$userInput
else

        title="Pick an active GPT conversation"
	export FOLDER=/tmp/chat_cache/
	export FILTER=*

	export ATOMIQUE_ROOT_DIR="$(dirname "$(readlink -f "$0")")"
	source "$ATOMIQUE_ROOT_DIR/inc/inc_select_file.sh"
	filename=$(basename "$selected_file")
fi
clear
                                                                      
if [ -z "$filename" ]; then                                                      filename="default_conversation"
fi      
tmux rename-window "gpt-chat-$filename"
echo $SEPLINE
echo "Shell-GPT Conversation:: $filename"
echo $SEPLINE
sgpt --repl --chat "$filename"

else
    echo "You chose Elia"
elia
fi
fi

