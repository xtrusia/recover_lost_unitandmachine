#!/bin/bash

read -d '' -r cmds <<'EOF'
conf=/var/lib/juju/agents/machine-*/agent.conf
user=`sudo grep tag $conf | cut -d' ' -f2`
password=`sudo grep statepassword $conf | cut -d' ' -f2`
/usr/lib/juju/mongo*/bin/mongo 127.0.0.1:37017/juju --authenticationDatabase admin --ssl --sslAllowInvalidCertificates --sslAllowInvalidHostnames --username "$user" --password "$password" \
--eval 'db.units.find({name:"etcd/0"})'
EOF

juju ssh -m controller 0 -o LogLevel=QUIET "$cmds"
