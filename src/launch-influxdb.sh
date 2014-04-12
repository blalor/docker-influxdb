#!/bin/bash

set -e -u

## ensure volume is properly prepared
for d in /var/lib/influxdb/{raft,db,wal} ; do
    [ -d $d ] || mkdir -p $d
done

chown -R influxdb:influxdb /var/lib/influxdb

exec runuser -s /bin/bash influxdb -c "/opt/influxdb/influxdb -config=/etc/influxdb.toml"
