# Session 2 · Lab 7: Configure NTP, then put the logs in order

**Pairs** · 20 minutes · outcome: r1 and srv at stratum 9; the real order

Run everything from this session's folder: `cd s02`

## 1 · server on nms, clients on r1 and srv

```sh
# write config/nms, config/r1, config/srv/chrony.conf
for n in nms r1 srv; do
  docker exec clab-mdh-$n \
    chronyd -x -f /etc/lab/chrony.conf
done
sleep 10
docker exec clab-mdh-srv chronyc sources
```

Prints something like:

```sh
^* nms    8   6   17   ...
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

Run `chronyc tracking` on srv: what stratum, and why that number? Then write the five events in real order.
