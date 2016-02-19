#!/bin/bash

wget http://razzball.com/steamer-pitcher-projections/ -O razz_pit.html
./razz.py < razz_pit.html > razz_pit.csv

rm razz_pit.html
