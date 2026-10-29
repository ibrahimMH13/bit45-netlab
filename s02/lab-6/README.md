# Session 2 · Lab 6: Build the log collector, then log a change

**Individual** · 25 minutes · outcome: r1.log, srv.log and changes.log on nms

Run everything from this session's folder: `cd s02`

## Configure nms first, then the senders

```sh
# 1. write config/nms/rsyslog.conf, config/r1/ and config/srv/rsyslog.conf
for n in nms r1 srv; do docker exec clab-mdh-$n sh -c \
  'rsyslogd -N1 -f /etc/lab/rsyslog.conf && rsyslogd -f /etc/lab/rsyslog.conf'
done
docker exec clab-mdh-r1  logger -p local0.warning -t change 'eth2 shut by admin'
docker exec clab-mdh-srv logger -p daemon.err -t nginx 'portal stopped'
docker exec clab-mdh-r1  logger -p user.info 'admin logged in'
docker exec clab-mdh-nms sh -c 'ls /var/log/remote; cat /var/log/remote/changes.log'
```

Prints something like:

```sh
changes.log  nms.log  r1.log  srv.log
Oct 29 10:14:02 r1 <132> change: eth2 shut by admin
```

## Then verify

Open `srv.log` and `r1.log`. Decode the two other priorities by hand. Which of the three messages would you send to the on-call phone?
