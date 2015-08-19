#!/bin/bash

scriptdir=`dirname "$BASH_SOURCE"`
source "$scriptdir/shared"

domain=$(serveradmin settings mail:postfix:mydomain | awk '{print $3}' | tr -d '"')

if [ -z "$domain" ]
then
    echo "Unabe to find server first domain"
    echo "Please check your mail service config and be sure to run this tool as root"
    exit 1
fi

mkdir "$TMP_PATH"
TMP_CONFIG="$TMP_PATH/config"

cp "$RC_SRC_SETTINGS_PATH" "$TMP_CONFIG"

sed -i -e "s@%%INSTALLATION_ROOT%%@$TARGET_PATH@g" "$TMP_CONFIG"
sed -i -e "s@%%HOSTNAME%%@$(hostname)@g" "$TMP_CONFIG"
sed -i -e "s@%%DOMAIN%%@$domain@g" "$TMP_CONFIG"
sed -i -e "s@%%SQLITE_PATH%%@$RC_DB_SQLITE_PATH@g" "$TMP_CONFIG"

KEY=$(uuidgen | awk -F'-' '{print $1"-"$2"-"$3"-"$4"-"}')

sed -i -e "s@%%RAND_24%%@$KEY@g" "$TMP_CONFIG"

mv "$TMP_CONFIG" "$RC_FINAL_SETTINGS_PATH" 

cp "$RC_CARDDAV_SRC_SETTINGS_PATH" "$RC_CARDDAV_FINAL_SETTINGS_PATH"
cp "$RC_SIEVE_SRC_SETTINGS_PATH" "$RC_SIEVE_FINAL_SETTINGS_PATH"

rm -rf "$TMP_PATH"

exit 0
