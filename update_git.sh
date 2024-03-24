#!/usr/bin/env bash   

# ADD this to cron with
#

ATOMIQUE_ROOT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd $ATOMIQUE_ROOT_DIR
git pull

if [ -d "../atomique_haiku" ]; then
    cd ../atomique_haiku
    git pull
fi

if [ -d "../atomique_rust" ]; then
    cd ../atomique_rust
    git pull
fi
