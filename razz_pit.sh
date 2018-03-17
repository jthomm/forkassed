#!/bin/bash

wget https://razzball.com/steamer-pitcher-projections/ -O razz_pit.html --header="User-Agent: SomeRandomText"
./razz.py < razz_pit.html > razz_pit.csv

rm razz_pit.html
