# Create 3 nodes etcd cluster in docker container

This config will create docker 3 containers for development/ testing, this is not for production purpose.

### Ceate and run the cluster:
    $ ./run.sh

Etcd will be available on 23790, 23791 and 23792 ports on host.

### Delete the cluster, it will not save any data:
    $ docker rm -f etcd-node-{0,1,2}

