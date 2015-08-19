#!/bin/bash

scriptdir=`dirname "$BASH_SOURCE"`
source "$scriptdir/shared"

mkdir "$RC_DB_SQLITE_FOLDER"
sqlite3 "$RC_DB_SQLITE_PATH" < "$RC_PATH/SQL/sqlite.initial.sql"
sqlite3 "$RC_DB_SQLITE_PATH" < "$RC_PATH/plugins/carddav/dbinit/sqlite3.sql"

if [ $? -ne 0 ]; then
    exit 1
fi

exit 0
