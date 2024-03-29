#!/usr/bin/env bash   


#
# If script was included from main menu the dir is already defined
# otherwise point to parent of 'cmd' dir
if [ -z "$ATOMIQUE_ROOT_DIR" ]
then
        export ATOMIQUE_ROOT_DIR="$(dirname "$(readlink -f "$0")")/../"
fi

datadir=~/atomique/data
echo "Updating data dir (git pull in $datadir)"

cd $datadir
git pull
git add .
git commit -a -m "full sync from atomique menu"
git push

read -n 1
