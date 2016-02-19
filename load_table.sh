#!/bin/bash

/usr/local/opt/sqlite/bin/sqlite3 -separator , db.sqlite3 ".import ${1}.csv ${1}"
