# Session 4 · Lab 2: Fill in the USE table for r1 during the upload

**Pairs** · 15 minutes · outcome: A USE table for eth1 and eth2 with numbers

Run everything from this session's folder: `cd s04`

## Terminal 1: load · terminal 2: read the queue

```sh
# terminal 1: a 60 s upload
docker exec clab-mdh-pc1 iperf3 -c 10.2.0.10 -t 60 -P 4
# terminal 2, after 30 s:
docker exec clab-mdh-r1 tc -s qdisc show dev eth2   # S and E
docker exec clab-mdh-r1 tc -s qdisc show dev eth1
docker exec clab-mdh-r1 cat /proc/loadavg            # CPU
# Grafana: utilisation panel = U for eth2
```

Prints something like:

```sh
qdisc bfifo 8012: parent 1:10 limit 3000000b
 Sent 259472283 bytes 27351 pkt (dropped 196, overlimits 0)
 backlog 2759060b 290p requeues 0
```

## Then verify

Divide the backlog (bytes × 8) by 50 Mbit/s. Compare the result with the ping RTT from task 1. Then query `ifOutDiscards` for r1 eth2 in Prometheus: does SNMP see the drops?
