#!/bin/bash

showtxt() {
    local file="$1"
    local lines_to_display=5
    local lines
    local key

    while IFS= read -r -t 1 line || [[ -n "$line" ]]; do
        lines+=("$line")

        if (( ${#lines[@]} == lines_to_display )); then
            # Display the lines
            printf "%s\n" "${lines[@]}"

            # Wait for a key press
            read -n 1 -s -p "Press any key to continue..."
            # Reset the lines array
            lines=()
        fi
    done < "$file"

    # Display any remaining lines
    if (( ${#lines[@]} > 0 )); then
        printf "%s\n" "${lines[@]}"
        read -n 1 -s -p "Press any key to exit..."
    fi

}

#file="$SCRIPT_DIR/atomique_about_text.txt"
file="atomique_about_text.txt"
showtxt $file


