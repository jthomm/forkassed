#!/bin/bash

wget http://claydavenport.com/projections/pitcher_projections.txt -O clay_pit.txt
sed 's/ \{1,\}/,/g' clay_pit.txt | sed 's/,$//g' > clay_pit.csv
rm clay_pit.txt
