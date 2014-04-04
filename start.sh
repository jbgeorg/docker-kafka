#!/bin/bash

# Necessary?
export JMX_PORT=7203

echo "ZOOKEEPER_IP=$ZOOKEEPER_PORT_2181_TCP_ADDR"

cat /kafka/config/server.properties.tmpl \
  | sed "s|{{ZOOKEEPER_IP}}|${ZOOKEEPER_PORT_2181_TCP_ADDR:-localhost}|g" \
  | sed "s|{{BROKER_ID}}|${BROKER_ID:-0}|g" \
  | sed "s|{{CHROOT}}|${CHROOT:-}|g" \
  | sed "s|{{EXPOSED_HOSTNAME}}|${EXPOSED_HOSTNAME:-localhost}|g" \
   > /kafka/config/server.properties

echo "Starting kafka"
/kafka/bin/kafka-server-start.sh /kafka/config/server.properties 2>&1 | tee /logs/kafka.log