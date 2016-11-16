#!/bin/sh

service apache2 restart >> /var/log/syslog
return 0