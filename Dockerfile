FROM blalor/supervised:latest
MAINTAINER Brian Lalor <blalor@bravo5.org>

## 80 - admin and api interfaces
## 2003 - Graphite
## 8090 - raft, used for clustering
## 8099 - protobuf, used for clustering
EXPOSE 80 2003 2003/udp 8090 8099

ADD src /tmp/src/
RUN /tmp/src/config.sh

VOLUME [ "/var/lib/influxdb" ]
