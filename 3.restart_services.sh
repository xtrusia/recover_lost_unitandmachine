#!/bin/bash

unit=${1:-etcd/0}
origin_unit=${2:-etcd/2}
machine=${3:-machine-6}

origin_unit_dir_fmt=unit-${origin_unit/\//-}
unit_dir_fmt=unit-${unit/\//-}

#restart daemons
juju ssh $unit -o LogLevel=QUIET "sudo systemctl daemon-reload"
juju ssh $unit -o LogLevel=QUIET "sudo rm -rf /var/snap/etcd/current/member/*"
juju ssh $unit -o LogLevel=QUIET "sudo systemctl restart snap.etcd.etcd.service"
sleep 10
juju ssh $unit -o LogLevel=QUIET "sudo systemctl restart jujud-$unit_dir_fmt.service"
juju ssh $unit -o LogLevel=QUIET "sudo systemctl restart jujud-$machine.service"
