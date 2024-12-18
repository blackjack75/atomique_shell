#!/usr/bin/env bash 

# selected_server MUST be defined by parent script 

trim_spaces() {
    for var in "$@"; do
        # Use indirect expansion to update the variable passed
        eval "$var=\"\$(echo -e \${$var} | xargs)\""
    done
}


server_name=$(echo "$selected_server" | awk -F '|' '{print $1}')
server_host_and_user=$(echo "$selected_server" | awk -F '|' '{print $2}')
server_port=$(echo "$selected_server" | awk -F '|' '{print $3}')
server_keywords=$(echo "$selected_server" | awk -F '|' '{print $4}')

trim_spaces server_name server_host_and_user server_port server_keywords



#Separate host and user in other variables
server_host=$(echo "$server_host_and_user" | awk -F '@' '{print $2}')
server_user=$(echo "$server_host_and_user" | awk -F '@' '{print $1}')


trim_spaces server_host server_user

