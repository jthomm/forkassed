#!/bin/bash

rm -f cbs_pit.csv

for pos in SP RP; do
  ./cbs.sh $pos
  ./cbs_pit.py $pos < cbs_${pos}.html >> cbs_pit.csv
  rm cbs_${pos}.html
done
