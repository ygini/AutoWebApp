#!/bin/bash

scriptdir=`dirname "$BASH_SOURCE"`
source "$scriptdir/shared"

chown -R www:www $ICINGA_SRC_FOLDER

exit 0
