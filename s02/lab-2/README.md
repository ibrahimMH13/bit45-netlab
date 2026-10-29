# Session 2 · Lab 2: Configure SNMP on r1 and srv

**Individual** · 20 minutes · outcome: Both agents answer nms; r1 refuses pc1

Run everything from this session's folder: `cd s02`

## Write the file, start the agent, test

```sh
# 1. write config/r1/snmpd.conf (previous slide)
# 2. write config/srv/snmpd.conf: location 'MDH-Net server room, rack 1'
docker exec clab-mdh-r1  sh -c 'pkill snmpd; snmpd -C -c /etc/lab/snmpd.conf'
docker exec clab-mdh-srv sh -c 'pkill snmpd; snmpd -C -c /etc/lab/snmpd.conf'
docker exec clab-mdh-nms snmpwalk -v2c -c public 172.30.30.3 system
# no answer? run it in the foreground to see the error (Ctrl+C):
docker exec clab-mdh-r1  sh -c 'pkill snmpd; snmpd -f -Le -C -c /etc/lab/snmpd.conf'
```

Prints something like:

```sh
SNMPv2-MIB::sysName.0 = STRING: srv
SNMPv2-MIB::sysLocation.0 = STRING: MDH-Net server room, rack 1
```

## Then verify

Prove the access control: from pc1, `snmpget -v2c -c public 10.1.0.1 sysName.0` must time out (install the tools there first: `apk add net-snmp-tools`).
