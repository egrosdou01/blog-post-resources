## Execute CNI Connectivity Test

```bash
$ TARGET_IP=$(kubectl get pod probe-target -n cni-net-test \
  -o jsonpath='{.status.podIP}')
```

```bash
$ kubectl exec -it probe-client -n cni-net-test -- \
  sh -c "
    while true; do
      ts=\$(date -u +%Y-%m-%dT%H:%M:%SZ)
      if nc -w 1 $TARGET_IP 8080 </dev/null >/dev/null 2>&1; then
        echo \"\$ts OK\"
      else
        echo \"\$ts FAIL\"
      fi
      sleep 1
    done
  "
```