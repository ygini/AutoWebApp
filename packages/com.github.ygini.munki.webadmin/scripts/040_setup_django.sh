#!/bin/bash

scriptdir=`dirname "$BASH_SOURCE"`
source "$scriptdir/shared"

source "$ENV_PATH/bin/activate"

echo "#############################################################"
echo "######### NEXT STEP WILL REQUIRE ADMIN ACCOUNT INFO #########"
echo "#############################################################"

python "$MWA_PATH/manage.py" syncdb -v 0
python "$MWA_PATH/manage.py" collectstatic --noinput > /dev/null

exit 0
