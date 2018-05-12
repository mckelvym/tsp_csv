#!/bin/bash

cd /data
curl --data "whichButton=CSV" https://www.tsp.gov/InvestmentFunds/FundPerformance/index.html | sed '1d' > tspsharePriceHistory.csv

cat tspsharePriceHistory.csv tspsharePriceHistoryMax.csv > tmp
cat tmp | awk -F ',' 'BEGIN {ORS=""; maxF = 0; max[2]=0} NF {if (NF > maxF) {maxF = NF} for (i=1; i < NF; i++) { print $i "," ; if (i > 1 && $i+0>0 && $i > max[i]) {max[i] = $i} } ; print "\n" ;} END {print "Max,"; for (i=2;i<maxF;i++) { print max[i] ","} print "\n" }' | tail -n 1 > tspsharePriceHistoryMax.csv
rm tmp
exit
