#!/bin/bash

/usr/local/opt/sqlite/bin/sqlite3 db.sqlite3 "DROP TABLE ${1};"
