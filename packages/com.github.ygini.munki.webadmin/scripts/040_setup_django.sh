#!/bin/bash

scriptdir=`dirname "$BASH_SOURCE"`
source "$scriptdir/shared"

source "$ENV_PATH/bin/activate"

cd "$MWA_PATH"


echo "#############################################################"
echo "######### NEXT STEP WILL REQUIRE ADMIN ACCOUNT INFO #########"
echo "#############################################################"

python manage.py syncdb -v 0
python manage.py collectstatic --noinput > /dev/null

exit 0
