#!/bin/bash

scriptdir=`dirname "$BASH_SOURCE"`
source "$scriptdir/shared"


if [[ $EUID -ne 0 ]]; then
    echo "###############################################"
    echo "### PLEASE, WE NEED YOU TO FIX PERMISSIONS. ###"
    echo "###############################################"
    echo ""
    echo "This tool isn't started with root privileges, so you need to execute this command as root:"
    echo "chown -R www:www $TARGET_PATH/munkiwebadmin"

else
    chown -R www:www $TARGET_PATH/munkiwebadmin
fi

exit 0