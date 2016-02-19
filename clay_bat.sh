#!/bin/bash

wget http://claydavenport.com/projections/hitter_projections.txt -O clay_bat.txt
sed 's/ \{1,\}/,/g' clay_bat.txt | sed 's/,$//g' > clay_bat.csv
rm clay_bat.txt
