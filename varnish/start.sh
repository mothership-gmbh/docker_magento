#!/bin/bash

set -e

python /assemble_vcls.py



exec


varnishd -a localhost:80 -f /etc/varnish/default.vcl -T localhost:6082 -F -s malloc,128M  -p default_ttl=3600 -p default_grace=3600