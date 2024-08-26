#!/usr/bin/env bash

ATOMIQUE_ROOT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

platform='unknown'
unamestr=$(uname)
if [ "$unamestr" = 'Linux' ]; then
	   platform='linux'
   elif [ "$unamestr" = 'FreeBSD' ]; then
	      platform='freebsd'
else
    echo "Unsupported platform: $unamestr. Aborting script."
    exit 1
fi


#-----------------------
LOCALUSER=$(whoami)
DEST_CRON_UPD=/etc/cron.d/atomique_shell_cron_update_entry
echo "-------------------------------------"
echo " ⏰ ADDIN CRON UPDATE for git pull"
echo " dest path: $DEST_CRON_UPD"
echo "------------------------------------"
#THIS MUST RUN AS normal user (usually 'pi' but it can be root on DietPI)
sudo cp -f "$ATOMIQUE_ROOT_DIR/atomique_shell_cron_update_entry" $DEST_CRON_UPD

SEDOPTION="-i"

if [[ "$OSTYPE" == "darwin"* ]]; then
  SEDOPTION="-i ''"
fi

#Replace the path of script and the user
#We use : and not / as separator so we don't have to escape slashes in path
sudo sed $SEDOPTION -e "s:REPLACEMEPATH:$ATOMIQUE_ROOT_DIR:g" "$DEST_CRON_UPD"
sudo sed $SEDOPTION -e "s:REPLACEMEUSER:$LOCALUSER:g" "$DEST_CRON_UPD"

#-----------------------


