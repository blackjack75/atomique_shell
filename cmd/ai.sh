#!/usr/bin/env bash
 
# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$ATOMIQUE_ROOT_DIR" ]
then
        export ATOMIQUE_ROOT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi

THISWIN=atomique-ia-$1

if tmux list-windows | grep -q "$THISWIN"; then
    
    #make sure this goes back to menu
    tmux rename-window "atomique-menu"
    
    tmux select-window -t "$THISWIN"
    exit 0

else 

	
tmux rename-window "$THISWIN"






ollama_host_file=~/atomique/data/ollama_hosts.txt
echo loading ollama hosts from $ollama_host_file
declare -A hosts


while IFS='|' read -r identifier url; do
    # Trim leading and trailing spaces from both identifier and url
    identifier=$(echo "$identifier" | xargs)
    url=$(echo "$url" | xargs)

    echo ..$identifier..$url..

    hosts["$identifier"]="$url"
done < "$ollama_host_file"



#for id in "${!hosts[@]}"; do
#    echo "$id -> ${hosts[$id]}"
#done

#export OLLAMA_HOST="http://10.22.22.40:11434"

export OLLAMA_HOST=${hosts[$1]}

echo launching ..ID..$1.. on ..$OLLAMA_HOST..

lazyollama

fi
