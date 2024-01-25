#!/usr/bin/env bash   

# ADD this to cron with
#

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

echo "Updating code (git pull in $SCRIPT_DIR) "
cd $SCRIPT_DIR
./update_git.sh

datadir=~/atomique/data
echo "Updating data dir (git pull in $datadir)"

cd $datadir
./update_git.sh


