#!/bin/bash

path="$1"

if [ "$path" == "" ] ; then
    echo "Specify path."
    exit 1
fi

cd "$path"
merge_name=tspsharePriceHistory.csv
out_name=tspsharePriceHistory_tmp.csv
archive_name=tspsharePriceHistory`date "+%Y%m%d"`.csv
docker pull registry.hub.docker.com/mckelvym/tsp.price:1.0.0 && docker run --rm --name=tsp-harvester -u $(id -u):$(id -g) -v "$PWD":/data registry.hub.docker.com/mckelvym/tsp.price:1.0.0 --merge-file=/data/$merge_name --out-file=/data/$out_name
if [ -s $out_name ] ; then
    mv $out_name $merge_name
    cp -v $merge_name $archive_name

    git add -u && \
	git commit -m "Daily update $archive_name" && \
	git push

    head $merge_name
else
    echo "WARN! File was zero size!"
fi
exit


