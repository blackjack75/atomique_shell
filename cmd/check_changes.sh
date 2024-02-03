#!/usr/bin/env bash   
 
# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$SCRIPT_DIR" ]
then
        export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi

clear
#tmux rename-window "atomique-tint"

DIR=~/atomique/data

#Show a fortune for 5 sec before launching before checking git
clear

# Get a random short fortune
fort=$(fortune -s -n 160)
dt=$(date +'%H:%M')
echo "   $dt"
echo -e "\e[37m💡 $fort\e[0m"
sleep 10 



echo Checking $DIR
cd $DIR

current_branch=$(git rev-parse --abbrev-ref HEAD)
remote_status="?"
local_status="?"

first=1

while true; do
   
clear       

# Check if there are changes in the current branch that need committing
local_changes_count=$(git status --porcelain | wc -l | xargs)
if [[ $local_changes_count -gt 0 ]]; then
    local_status="⚠️ Local files changed"
    changed_files=$(git status --porcelain | awk '{ print $2 }' | tr '\n' ', ')
    changed_files="${changed_files%, }" # Remove trailing comma and space
    changed_files="($changed_files)"
else
    local_status="✅ No local changes"
    changed_files=""
fi


echo "$local_status ( $current_branch ) $changed_files"

   if [[ $(($(date +%s) % 30)) -eq 0 || $first -eq 1 ]]; then
        first=0
	# Get the URL of the remote repository
	remote_url=$(git config --get remote.origin.url)

	# Get the hash of the latest commit in the remote repository
	latest_remote_commit=$(git ls-remote "$remote_url" HEAD | awk '{ print $1 }')

	# Get the hash of the latest commit in the local repository
	latest_local_commit=$(git rev-parse HEAD)

	# Check if the latest commit in the remote repository is different from the latest commit in the local repository
	if [[ "$latest_remote_commit" != "$latest_local_commit" ]]; then
	    remote_status="⚠️ Remote has changed update needed $(date +'%H:%M:%S')"
	else
	    remote_status="✅ No remote changes  $(date +'%H:%M:%S')"
	fi


fi
       echo "$remote_status ( $current_branch )" 

       sleep 5

done

