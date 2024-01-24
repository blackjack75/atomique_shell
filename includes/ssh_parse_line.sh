#!/usr/bin/env bash 

# selected_server MUST be defined by parent script 

server_name=$(echo "$selected_server" | awk -F '|' '{print $1}')
server_host_and_user=$(echo "$selected_server" | awk -F '|' '{print $2}')

server_host=$(echo "$server_host_and_user" | awk -F '@' '{print $2}')
server_user=$(echo "$server_host_and_user" | awk -F '@' '{print $1}')

server_port=$(echo "$selected_server" | awk -F '|' '{print $3}')
server_keywords=$(echo "$selected_server" | awk -F '|' '{print $4}')
