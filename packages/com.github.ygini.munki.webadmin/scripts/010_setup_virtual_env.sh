#!/bin/bash

scriptdir=`dirname "$BASH_SOURCE"`
source "$scriptdir/shared"

type virtualenv > /dev/null

if [ $? -ne 0 ]
then
    easy_install virtualenv
    if [ $? -ne 0 ]
    then
        echo "####################################################################################################"
        echo "### Impossible to install Python virtualenv, please, do it by your own or run this tool as root. ###"
        echo "####################################################################################################"
        exit 1
    fi
fi

echo "# Deploying new python virtualenv ($ENV_PATH)"

virtualenv "$ENV_PATH" > /dev/null

source "$ENV_PATH/bin/activate"

echo "# Installing Django 1.5.1 in virtual env"
pip -q install django==1.5.1 > /dev/null

exit 0