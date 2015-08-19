#!/bin/bash

scriptdir=`dirname "$BASH_SOURCE"`
source "$scriptdir/shared"

cp "$BASE_FOLDER/files/munkiwebadmin.wsgi" "$TARGET_PATH/munkiwebadmin.wsgi"

cp "$MWA_PATH/settings_template.py" "$MWA_DEFAULT_SETTINGS_PATH"

echo "" >> "$MWA_DEFAULT_SETTINGS_PATH"
echo "### autowebapp settings ###" >> "$MWA_DEFAULT_SETTINGS_PATH"
echo "from $MWA_SETTINGS_PARSER_FILENAME import *" >> "$MWA_DEFAULT_SETTINGS_PATH"

cp "$MWA_CONFIG_PARSER_SRC" "$MWA_SETTINGS_PARSER_PATH"

shasum "$MWA_DEFAULT_SETTINGS_PATH" >> "$CHECKSUM_LIST"
shasum "$MWA_SETTINGS_PARSER_PATH" >> "$CHECKSUM_LIST"


echo "# autowebapp configuration file" >> "$MWA_SETTINGS_INI_PATH"
echo "# the recommanded way to edit this file is with autowebapp setSettings" >> "$MWA_SETTINGS_INI_PATH"
echo "" >> "$MWA_SETTINGS_INI_PATH"

echo "[django]" >> "$MWA_SETTINGS_INI_PATH"
SECRET_KEY=$(openssl rand -base64 42)
echo "secret_key = $SECRET_KEY" >> "$MWA_SETTINGS_INI_PATH"
echo "" >> "$MWA_SETTINGS_INI_PATH"

echo "[munki]" >> "$MWA_SETTINGS_INI_PATH"
echo "path=/Users/Shared" >> "$MWA_SETTINGS_INI_PATH"
echo "" >> "$MWA_SETTINGS_INI_PATH"

echo "[munkiwebadmin]" >> "$MWA_SETTINGS_INI_PATH"
echo "timezone=UTC" >> "$MWA_SETTINGS_INI_PATH"
echo "warranty=No" >> "$MWA_SETTINGS_INI_PATH"
echo "model=No" >> "$MWA_SETTINGS_INI_PATH"
echo "proxy=" >> "$MWA_SETTINGS_INI_PATH"

exit 0
