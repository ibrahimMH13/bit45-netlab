# Session 3 · Lab 3: How busy is r1's link to pc1? One query.

**Pairs** · 15 minutes · outcome: About 100 kbit/s, on a graph

Run everything from this session's folder: `cd s03`

## Terminal: traffic · browser: Prometheus Query

```sh
# terminal: 10 pings per second, 1200 bytes, 40 s
docker exec clab-mdh-pc1 ping -q -c 400 -i 0.1 -s 1200 10.2.0.10

# Prometheus → Query → Graph tab:
rate(ifHCInOctets{instance="172.30.30.2",ifName="eth1"}[30s]) * 8
```

Prints something like:

```sh
{ifName="eth1", instance="172.30.30.2", job="snmp"}  103605
```

## Then verify

Change `[30s]` to `[5s]`. What happens, and why? Then change `eth1` to `eth2`: is the rate on r1's other link the same?
