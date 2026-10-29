# Session 1 · Lab 4: Baseline, degrade, measure again

**Individual** · 20 minutes · outcome: A before/after table with three numbers each

Run everything from this session's folder: `cd s01`

## Measure, change, measure

```sh
./break.sh --fix                       # start clean
docker exec clab-mini-pc1 ping -q -c 20 10.2.0.10   # 1 before
sudo containerlab tools netem set -n clab-mini-r1 \
     -i eth2 --delay 80ms --loss 10    # slow + lossy
docker exec clab-mini-pc1 ping -q -c 20 10.2.0.10   # 2 during
sudo containerlab tools netem reset -n clab-mini-r1 -i eth2
docker exec clab-mini-pc1 ping -q -c 20 10.2.0.10   # 3 after
```

Prints something like:

```sh
20 packets transmitted, 18 received, 10% packet loss
rtt min/avg/max/mdev = 80.6/82.9/86.0/1.9 ms
```

## Then verify

Your table has three rows (before, during, after) and three columns: avg latency, max latency, loss. 'After' should match 'before'.
