containerd --config /etc/containerd/config.toml > /tmp/containerd.log 2>&1 &
containerd_pid=$!
until [ -S /run/containerd/containerd.sock ]; do
  sleep 1
done
dockerd --containerd=/run/containerd/containerd.sock \
  --storage-driver=vfs --bridge=none > /tmp/docker.log 2>&1 &
daemon=$!
until [ -S /var/run/docker.sock ]; do
  sleep 1
done
until docker info > /dev/null 2>&1; do
  sleep 1
done
