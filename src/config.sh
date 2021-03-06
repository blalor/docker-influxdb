#!/bin/bash

set -e -u -x

cd /tmp/src

## create user
groupadd -g 600 influxdb
useradd -g influxdb -u 600 -r influxdb

## install files
mv influxdb.toml /etc/
mv launch-influxdb.sh /usr/local/bin/
mv program-*.conf /etc/supervisor.d/
mv logstash-forwarder-*.json /etc/logstash-forwarder.d/

yum localinstall -y http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
yum install -y nginx

mv nginx.conf /etc/nginx/

## install influxdb
mkdir /opt/influxdb
curl http://s3.amazonaws.com/influxdb/influxdb-0.7.2.amd64.tar.gz | tar -xzf - --strip-components=1 -C /opt/influxdb/

## set ownership; defaults to 500
chown -R root:root /opt/influxdb

## create required directories and set permissions
## /var/lib/influxdb is a volume, so this is a little pointless since it'll be
## /recreated by launch-influxdb.sh
mkdir -p /var/log/influxdb /var/lib/influxdb/{raft,db,wal}
chown -R influxdb:influxdb /var/{log,lib}/influxdb

## cleanup
cd /
yum clean all
rm -rf /var/tmp/yum-root* /tmp/src
