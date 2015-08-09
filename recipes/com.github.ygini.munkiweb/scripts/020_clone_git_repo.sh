#!/bin/bash

scriptdir=`dirname "$BASH_SOURCE"`
source "$scriptdir/shared"

test_for_git=$(git | grep xcode | wc -l | bc)

if [ $test_for_git -ne 0 ]
then
    echo "Git is required for this process and isn't installed on the system."
    echo "A Software Update window has pop on your screen, please, accept to install now"

    read -rsp $'Press any key to continue when the installation is over...\n' -n1 key
fi

echo "# Cloning MunkiWebAdmin sources from GitHub"

git clone https://github.com/munki/munkiwebadmin "$MWA_PATH" > /dev/null

exit 0
