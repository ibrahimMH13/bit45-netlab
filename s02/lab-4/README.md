# Session 2 · Lab 4: SNMP versions: v1 and v2c send the password in the open

**Individual** · 8 min · outcome: see it yourself

Run everything from this session's folder: `cd s02`

```sh
# nms, terminal 1
tcpdump -i eth0 -n -A udp port 161
# nms, terminal 2
snmpget -v2c -c public 172.30.30.2 sysName.0
```

Prints something like:

```sh
....public......  <- the password
```
