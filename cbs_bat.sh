#!/bin/bash

rm -f cbs_bat.csv

for pos in C 1B 2B SS 3B OF DH; do
  ./cbs.sh $pos
  ./cbs_bat.py $pos < cbs_${pos}.html >> cbs_bat.csv
  rm cbs_${pos}.html
done
