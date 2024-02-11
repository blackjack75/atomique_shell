#!/usr/bin/env bash   


# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$ATOMIQUE_ROOT_DIR" ]
then
        export ATOMIQUE_ROOT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi
tmux rename-window "atomique-self-update"

echo "Updating code (git pull in $ATOMIQUE_ROOT_DIR) "
cd $ATOMIQUE_ROOT_DIR
./update_git.sh


