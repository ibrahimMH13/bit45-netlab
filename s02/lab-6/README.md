# Session 2 · Lab 6: Check the offset, then put the logs in order

**Pairs** · 15 minutes · outcome: The offset of r1, and the real order of events

Run everything from this session's folder: `cd s02`

## 1 · ask nms for the time (5 s)

```sh
docker exec clab-mdh-r1 \
  timeout 5 ntpd -n -w -p 172.30.30.10
```

Prints something like:

```sh
reply from 172.30.30.10:
  offset:+0.000021 delay:0.000215
  strat:1
```

## 2 · r1's clock is 7 min fast. What happened first?

```sh
srv  10:02:10  nginx: portal stopped
r1   10:08:40  change: eth2 shut by admin
pc1  10:01:55  user: portal slow
srv  10:01:50  kernel: eth1 errors rising
r1   10:09:05  change: eth2 enabled
```

## Then verify

Write the five events in real order. Did the admin's change cause the outage, or come after it?
