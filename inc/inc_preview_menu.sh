#!/usr/bin/env bash 

piped_input=""

# Read input line by line and append to the variable
while IFS= read -r line; do
    piped_input+="$line"
done

selected_menu=$piped_input
export selected_menu

# Define variables
source "$SCRIPT_DIR/inc/inc_parse_line_menu.sh"

echo $SEPLINE
echo " $title - $menu_title" 
echo $SEPLINE

echo " Command: $menu_command"
echo " Info:    $menu_info"

echo $SEPLINE


