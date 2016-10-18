FROM alpine:latest

RUN apk --no-cache add curl tar

# Download and install only binaries, use pipe with curl to avoid saving .gz file into the docker layer
RUN curl -L https://github.com/coreos/etcd/releases/download/v3.0.12/etcd-v3.0.12-linux-amd64.tar.gz \
    | tar xzv -C /usr/local/bin/ --wildcards "etcd-*/etcd" --wildcards "etcd-*/etcdctl" --strip-components=1

RUN mkdir -p /var/etcd/ /var/lib/etcd/

EXPOSE 2379 2380

# Define default command.
CMD ["/usr/local/bin/etcd"]

