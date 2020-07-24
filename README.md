# TSP CSV Docker Tool

```
docker build -t tsp_csv .

docker tag tsp_csv mckelvym/tsp_csv:latest
docker push mckelvym/tsp_csv:latest

docker run -v `pwd`:/data -u 1000:1000 mckelvym/tsp_csv:latest
```

