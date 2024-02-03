#!/usr/bin/env bash   

# ADD this to cron with
#

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd ~/atomique/data
git pull
