#!/bin/bash

barf() { echo "Fatal: $@ -- did not execute properly." 1>&2; exit $1; }
safe() { "$@" || barf "$?" "$@"; }

for table in stmr_norm_bat stmr_norm_pit dept_pit dept_bat atc_bat atc_pit razz_pit razz_bat
do
  echo "Working on ${table}"
  #echo "Dropping table..."
  #./drop_table.sh $table
  echo "Creating..."
  safe ./create_table.sh $table
  echo "Loading..."
  safe ./load_table.sh $table
  echo "Done!\n"
done
