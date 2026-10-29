# Session 2 · Lab 5: Log a change, then find it at the collector

**Individual** · 15 minutes · outcome: Three messages decoded: facility and severity

Run everything from this session's folder: `cd s02`

## Send from r1 and srv, read on nms

```sh
docker exec clab-mdh-r1  logger -p local0.warning -t change 'eth2 shut by admin'
docker exec clab-mdh-srv logger -p daemon.err -t nginx 'portal stopped'
docker exec clab-mdh-r1  logger -p user.info 'admin logged in'

docker exec clab-mdh-nms cat /var/log/network.log
# only warnings and worse from facility local0 (16×8 + 0..4):
docker exec clab-mdh-nms grep -E '<12[89]>|<13[0-2]>' /var/log/network.log
```

Prints something like:

```sh
172.30.30.2 <132>Oct 29 10:14:02 change: eth2 shut by admin
172.30.30.3 <27>Oct 29 10:14:03 nginx: portal stopped
```

## Then verify

Decode <27> and the third message by hand. Then: which of the three would you send to the on-call phone?
