# Session 4 · Lab 3: Fix the queue twice and measure each

**Individual** · 20 minutes · outcome: Ping under load in ms for each queue

Run everything from this session's folder: `cd s04`

## Edit config/r1/qos.sh, apply, measure

```sh
# A: change 'bfifo limit 3000000' to 'bfifo limit 100000'
./apply.sh && ./measure.sh
# B: replace the whole bfifo line with:
#    tc qdisc add dev eth2 parent 1:10 fq_codel
./apply.sh && ./measure.sh
docker exec clab-mdh-r1 tc -s qdisc show dev eth2
```

Prints something like:

```sh
rtt min/avg/max/mdev = 11.8/14.4/16.9/1.6 ms      # A
upload: [SUM]  0.00-24.06 sec  141 MBytes  49.2 Mbits/sec
```

## Then verify

Fix A: does your measured RTT match the 16 ms you can calculate? Fix B: in the `tc -s` output, find `drop_overlimit` and `new_flows_len`. What did fq_codel do?
