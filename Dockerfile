FROM crystallang/crystal:0.33.0-alpine

COPY . /mazes.cr
WORKDIR /mazes.cr

ENTRYPOINT ["crystal", "spec"]