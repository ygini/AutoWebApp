#!/bin/bash

scriptdir=`dirname "$BASH_SOURCE"`
source "$scriptdir/shared"

number_of_root_folder=$(tar -tf "$ARCHIVE" | awk -F'/' '{print $1}' | sort | uniq | wc -l | bc)

if [ $number_of_root_folder -ne 1 ]
then
    echo "Download archive contain more than one root folder, this is not execpted"
    echo "The package need to be updated to handle this scenario"
    exit 1
fi

mkdir "$ICINGA_SRC_FOLDER"
tar xvf "$ARCHIVE" -C "$ICINGA_SRC_FOLDER"  --strip 1

exit 0
