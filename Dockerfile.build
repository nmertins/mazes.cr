FROM crystallang/crystal:0.33.0-alpine

COPY . /mazes.cr
WORKDIR /mazes.cr

RUN shards install 

ENTRYPOINT ["crystal", "spec"]