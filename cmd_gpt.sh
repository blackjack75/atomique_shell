#!/usr/bin/env bash   
 
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

	export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
	source "$SCRIPT_DIR/inc_select_file.sh"
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
