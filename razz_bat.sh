#!/bin/bash

wget http://razzball.com/steamer-hitter-projections/ -O razz_bat.html
./razz.py < razz_bat.html > razz_bat.csv

rm razz_bat.html
