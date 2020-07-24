#!/bin/bash

cd /data
out=tspsharePriceHistory.csv
max=tspsharePriceHistoryMax.csv
if ! curl "https://secure.tsp.gov/components/CORS/getSharePrices.html?InvFunds=1&format=CSV&download=1" | sed '1d' > $out ; then
   exit 1
fi
cat $out $max > tmp
cat tmp | awk -F ',' 'BEGIN {ORS=""; maxF = 0; max[2]=0} NF {if (NF > maxF) {maxF = NF} for (i=1; i < NF; i++) { print $i "," ; if (i > 1 && $i+0>0 && $i > max[i]) {max[i] = $i} } ; print "\n" ;} END {print "Max,"; for (i=2;i<maxF;i++) { print max[i] ","} print "\n" }' | tail -n 1 > $max
rm tmp
exit
