# Session 3 · Lab 2: Add a ping probe and SNMP to Prometheus

**Individual** · 20 minutes · outcome: Four targets UP on the Target health page

Run everything from this session's folder: `cd s03`

## Write two jobs, check, reload

```sh
# 1. config/prom/prometheus.yml: copy the portal-http job twice
#    portal-icmp: module icmp, target 10.2.0.10 (no http://)
#    snmp: metrics_path /snmp, module if_mib + auth public_v2,
#          targets 172.30.30.2 and .3, exporter 172.30.30.20:9116
./reload.sh                 # promtool check, then reload
# see what the snmp exporter returns for r1:
docker exec clab-mdh-pc1 curl -s \
  '172.30.30.20:9116/snmp?target=172.30.30.2&module=if_mib&auth=public_v2' | grep ifOperStatus
```

Prints something like:

```sh
SUCCESS: /etc/prometheus/prometheus.yml is valid prometheus config file syntax
ifOperStatus{ifDescr="eth1",ifIndex="24",ifName="eth1"} 1
```

## Then verify

Break the file on purpose (delete a space before `metrics_path`) and run `./reload.sh`. What does it print, and is Prometheus still running?
