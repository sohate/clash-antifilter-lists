#!/bin/bash

DIR="/var/www"

# Download antifilter list
curl -s https://antifilter.download/list/allyouneed.lst --output ${DIR}/antifilter.list
curl -s https://community.antifilter.download/list/community.lst --output ${DIR}/community.list

### Modify for Shadowrocket & Clash ###
# Shadowrocket
sed -i 's/^/IP-CIDR,/' ${DIR}/antifilter.list
sed -i 's/^/IP-CIDR,/' ${DIR}/community.list
# Clash
sed -e 's/^/  - /' ${DIR}/antifilter.list > ${DIR}/antifilter.yaml
sed -e 's/^/  - /' ${DIR}/community.list > ${DIR}/community.yaml
sed -i '1 i\payload:' ${DIR}/antifilter.yaml
sed -i '1 i\payload:' ${DIR}/community.yaml

# chown
chown abc:abc ${DIR}/antifilter.{yaml,list}
chown abc:abc ${DIR}/community.{yaml,list}
