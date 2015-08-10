#!/bin/bash

scriptdir=`dirname "$BASH_SOURCE"`
source "$scriptdir/shared"

echo "####################################################################################"
echo "### We need admin right to set munkiwebadmin correct permission for web service. ###"
echo "####################################################################################"

sudo chown -R www:www $TARGET_PATH/munkiwebadmin

exit 0