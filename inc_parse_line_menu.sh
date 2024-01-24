#!/usr/bin/env bash 

extract_and_trim() {
    local selected_menu="$1"
    extracted_field=$(echo "$selected_menu" | awk -F '|' "{print \$$2}")
    trimmed_result=$(echo "$extracted_field" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    echo "$trimmed_result"
}
# selected_menu MUST be defined by parent script 

menu_title=$(extract_and_trim "$selected_menu" "1")
menu_command=$(extract_and_trim "$selected_menu" "2")
menu_info=$(extract_and_trim "$selected_menu" "3")


