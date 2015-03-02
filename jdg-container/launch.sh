#!/bin/bash
/usr/bin/supervisord -c /etc/supervisord.conf 
/usr/bin/supervisorctl -c /etc/supervisord.conf
