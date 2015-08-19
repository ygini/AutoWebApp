#!/bin/bash

scriptdir=`dirname "$BASH_SOURCE"`
source "$scriptdir/shared"

sqlite3 "$TARGET_PATH/sqlite.db" < "$RC_PATH/SQL/sqlite.initial.sql"

if [ $? -ne 0 ]; then
    exit 1
fi

exit 0
