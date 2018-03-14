#!/bin/bash

barf() { echo "Fatal: $@ -- did not execute properly." 1>&2; exit $1; }
safe() { "$@" || barf "$?" "$@"; }

for table in clay_adj_bat clay_adj_pit pod_bat pod_pit zips_bat zips_pit stmr_pit stmr_bat stmr_norm_bat stmr_norm_pit dept_pit dept_bat atc_bat atc_pit fans_pit fans_bat clay_bat clay_pit razz_pit razz_bat
do
  echo "Working on ${table}"
  echo "Dropping table..."
  ./drop_table.sh $table
  echo "Creating..."
  safe ./create_table.sh $table
  echo "Loading..."
  safe ./load_table.sh $table
  echo "Done!\n"
done
