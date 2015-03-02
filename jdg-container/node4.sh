#!/bin/bash
IPADDR=$(ip a s | sed -ne '/127.0.0.1/!{s/^[ \t]*inet[ \t]*\([0-9.]\+\)\/.*$/\1/p}')  
$JDG_HOME/bin/clustered.sh -Djboss.node.name=jdg-4 -Djboss.socket.binding.port-offset=4 -Djboss.server.base.dir=$JDG_HOME/standalone4 -b $IPADDR -bmanagement $IPADDR
