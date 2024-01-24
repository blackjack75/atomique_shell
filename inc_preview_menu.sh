#!/usr/bin/env bash 

piped_input=""

# Read input line by line and append to the variable
while IFS= read -r line; do
    piped_input+="$line"
done

selected_server=$piped_input

# Define variables
source "$SCRIPT_DIR/inc_parse_line_menu.sh"

echo "---------------------------------"
echo  $title
echo "---------------------------------"

echo "Action:  $menu_title  " 
echo "Command: $menu_command"
echo "Info:    $menu_info"

echo "---------------------------------"

