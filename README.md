./0.recover_tools.sh etcd/0 etcd/2 machine-2

./1.recover_charm.sh etcd/0 etcd/2 etcd-378 controller 0 machine-2 machine-4

./2.recover_systemd.sh etcd/0 etcd/2 machine-2 machine-4

./3.restart_servies.sh etcd/0 etcd/2 machine-2

