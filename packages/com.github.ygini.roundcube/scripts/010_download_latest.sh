#!/bin/bash

scriptdir=`dirname "$BASH_SOURCE"`
source "$scriptdir/shared"

echo "Please, be sure to install the roundcube webapp only when your mail and contact service are properly started."
echo "Both services must be hosted on the same server as Roundcube."
echo "For mail service, please double check that you already have set your domain name in the mail settings pane."

result=$(ask_continue)
if [ "$result" == "no" ] 
then
    exit 1
fi

echo "# Getting last Roundcube version from SourceForge"

mkdir "$TMP_PATH"
mkdir "$RC_PATH"

curl -L http://sourceforge.net/projects/roundcubemail/files/latest/download > "$TMP_PATH/archive.tgz"

number_of_root_folder=$(tar -tf "$TMP_PATH/archive.tgz" | awk -F'/' '{print $1}' | sort | uniq | wc -l | bc)

if [ $number_of_root_folder -ne 1 ]
then
    echo "Download archive contain more than one root folder, this is not execpted"
    echo "The package need to be updated to handle this scenario"
    exit 1
fi

tar xvzf "$TMP_PATH/archive.tgz" -C "$RC_PATH"  --strip 1

if [ $? -ne 0 ]
then
    exit 1
fi

git clone -q https://github.com/blind-coder/rcmcarddav.git "$RC_PATH/plugins/carddav" > /dev/null

if [ $? -ne 0 ]
then
    exit 1
fi

cd "$RC_PATH/plugins/carddav"
curl -sS https://getcomposer.org/installer | php
php composer.phar install

rm -rf "$TMP_PATH"

exit 0
