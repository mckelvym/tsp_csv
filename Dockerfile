FROM alpine
RUN apk add --update bash curl && rm -rf /var/cache/apk/*
COPY tsp_csv.sh /run.sh
RUN chmod +x /run.sh
CMD ["/run.sh"]
