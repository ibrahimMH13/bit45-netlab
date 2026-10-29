# Session 2 · Lab 5: SNMP versions: v1 and v2c send the password in the open

**Individual** · 5 min · outcome: see it yourself

Run everything from this session's folder: `cd s02`

```sh
# terminal 1: capture SNMP on nms
docker exec -it clab-mdh-nms \
  tcpdump -i eth0 -n -A udp port 161
# terminal 2: one request
docker exec clab-mdh-nms snmpget \
  -v2c -c public 172.30.30.2 sysName.0
```

Prints something like:

```sh
....public......  <- the password
```
