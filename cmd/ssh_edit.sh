#!/usr/bin/env bash   


# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$SCRIPT_DIR" ]
then
        export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi


datafolder=~/atomique/data
servers_folder=~/atomique/data/servers

echo "Opening editor for SSH servers in  $servers_folder ..."

$EDITOR $servers_folder

read -n 1 -p "Do you want to commit any changes? (y/n): " commit_response
echo 

if [[ $commit_response == "y" ]]; then

echo "Will commit all changes on SSH servers..."

cd $datafolder

git add .
git commit -a -m "Edited servers"
git push

echo "Done!"

else 
    read -n 1 -p "Do you want to revert ALL changes in $datafolder ? (y/n): " revert_response
    echo
    if [[ $revert_response == "y" ]]; then
        echo "Reverting all changes in $datafolder ... "
	cd $datafolder
	git reset --hard
	echo "Done!"

    else
        echo "No changes were committed or reverted."
fi
fi


