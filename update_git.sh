#!/usr/bin/env bash   

# ADD this to cron with
#

ATOMIQUE_ROOT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd $ATOMIQUE_ROOT_DIR
git pull
