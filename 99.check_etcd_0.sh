#!/bin/bash

modeluuid="00f679ad-6797-47dc-8fc5-f4ea2b47bf87"

read -d '' -r cmds <<'EOF'
conf=/var/lib/juju/agents/machine-*/agent.conf
user=`sudo grep tag $conf | cut -d' ' -f2`
password=`sudo grep statepassword $conf | cut -d' ' -f2`
/usr/bin/mongo 127.0.0.1:37017/juju --authenticationDatabase admin --ssl --sslAllowInvalidCertificates --sslAllowInvalidHostnames --username "$user" --password "$password" \
--eval 'db.units.find({name:"etcd/0",
EOF

cmds="$cmds \"model-uuid\": \"$modeluuid\"})'"

echo $cmds

juju ssh -m controller 0 -o LogLevel=QUIET "$cmds"
