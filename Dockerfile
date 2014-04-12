FROM blalor/supervised:latest
MAINTAINER Brian Lalor <blalor@bravo5.org>

EXPOSE 2003 8083 8086 8090 8099

ADD src /tmp/src/
RUN /tmp/src/config.sh

VOLUME [ "/var/lib/influxdb" ]
