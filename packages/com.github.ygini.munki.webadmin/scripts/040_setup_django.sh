#!/bin/bash

scriptdir=`dirname "$BASH_SOURCE"`
source "$scriptdir/shared"

source "$ENV_PATH/bin/activate"

echo "#############################################################"
echo "######### NEXT STEP WILL REQUIRE ADMIN ACCOUNT INFO #########"
echo "#############################################################"

python "$MWA_PATH/manage.py" syncdb -v 0

if [ $? -ne 0 ]
then
    exit 1
fi

python "$MWA_PATH/manage.py" collectstatic --noinput > /dev/null

if [ $? -ne 0 ]
then
    exit 2
fi

exit 0
