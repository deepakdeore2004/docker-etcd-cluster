ETCD_VERSION=v3.0.12

docker build . -t etcd:$ETCD_VERSION
docker network create --subnet=10.10.10.0/24 etcd 2>/dev/null

TOKEN=my-etcd-token
CLUSTER_STATE=new
NAME=(etcd-node-0 etcd-node-1 etcd-node-2)
HOST=(10.10.10.11 10.10.10.12 10.10.10.13)
CLUSTER=${NAME[0]}=http://${HOST[0]}:2380,${NAME[1]}=http://${HOST[1]}:2380,${NAME[2]}=http://${HOST[2]}:2380

for i in 0 1 2; do
  OPTS="--link ${HOST[$i]}:${HOST[$i]}"
  docker run -itd --net etcd -p 2379${i}:2379 --ip ${HOST[$i]} --name ${NAME[$i]} --hostname ${NAME[$i]} etcd:$ETCD_VERSION \
    /usr/local/bin/etcd \
      --data-dir=data.etcd --name ${NAME[$i]} \
      --initial-advertise-peer-urls http://${HOST[$i]}:2380 --listen-peer-urls http://${HOST[$i]}:2380 \
      --advertise-client-urls http://${HOST[$i]}:2379 --listen-client-urls "http://127.0.0.1:2379,http://${HOST[$i]}:2379" \
      --initial-cluster ${CLUSTER} \
      --initial-cluster-state ${CLUSTER_STATE} --initial-cluster-token ${TOKEN}
done

