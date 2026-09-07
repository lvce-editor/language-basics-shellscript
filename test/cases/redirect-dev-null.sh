stty -echo -icanon 2>/dev/null || true
cat /tmp/containerd.log /tmp/docker.log 2>/dev/null || true
kill "$daemon" 2>/dev/null || true
containerd --config /opt/playground/containerd.toml >/tmp/containerd.log 2>&1 &
cat 2>>/dev/null
cat 0</dev/null
cat 12>/dev/null
cat 2>"/dev/null"
2>/dev/null cat /tmp/containerd.log
cat 2 > /dev/null
cat 2log
