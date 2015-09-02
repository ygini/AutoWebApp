#!/bin/bash

scriptdir=`dirname "$BASH_SOURCE"`
source "$scriptdir/shared"

/opt/local/bin/port selfupdate

/opt/local/bin/port install cmake
/opt/local/bin/port install boost
/opt/local/bin/port install mysql55

exit 0
