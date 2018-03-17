#!/bin/bash

wget https://razzball.com/steamer-hitter-projections/ -O razz_bat.html --header="User-Agent: SomeRandomText"
./razz.py < razz_bat.html > razz_bat.csv

rm razz_bat.html
