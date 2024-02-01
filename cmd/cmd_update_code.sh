#!/usr/bin/env bash   


# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$SCRIPT_DIR" ]
then
        export SCRIPT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi


echo "Updating code (git pull in $SCRIPT_DIR) "
cd $SCRIPT_DIR
./update_git.sh


