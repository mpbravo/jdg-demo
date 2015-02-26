#!/bin/sh
export SERVERS=$JDG_PORT_8081_TCP_ADDR:11223;$JDG_PORT_8081_TCP_ADDR:11224;$JDG_PORT_8081_TCP_ADDR:11225;$JDG_PORT_8081_TCP_ADDR:11226
$JBOSS_HOME/bin/standalone.sh -Djdg.visualizer.jmxUser=admin -Djdg.visualizer.jmxPass=redhat123. -Djdg.visualizer.serverList=$SERVERS -b 0.0.0.0 -bmanagement 0.0.0.0
