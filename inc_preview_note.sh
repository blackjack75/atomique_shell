#!/usr/bin/env bash 

piped_input=""

# Read input line by line and append to the variable
while IFS= read -r line; do
    piped_input+="$line"
done

selected_file=$piped_input


echo $SEPLINE
echo " $title - $menu_title" 
echo $SEPLINE

echo $selected_file
echo " Command: $menu_command"
echo " Info:    $menu_info"

echo $SEPLINE

