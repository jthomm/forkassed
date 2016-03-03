#!/bin/bash

POSITION=$1

wget "http://www.cbssports.com/fantasy/baseball/stats/sortable/cbs/${POSITION}/season/standard/projections?&print_rows=9999" -O cbs_${POSITION}.html
