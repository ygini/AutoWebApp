#!/bin/bash

scriptdir=`dirname "$BASH_SOURCE"`
source "$scriptdir/shared"

cd "$ICINGA_SRC_FOLDER"

mkdir build && cd build
$CMAKE_PATH .. -DCMAKE_INSTALL_PREFIX="$ICINGA_INSTALL_FOLDER" -DICINGA2_USER=$USER -DICINGA2_GROUP=$GROUP

if [ $? -ne 0 ]
then
    exit 1
fi

make

if [ $? -ne 0 ]
then
    exit 1
fi

make install

if [ $? -ne 0 ]
then
    exit 1
fi

exit 0
