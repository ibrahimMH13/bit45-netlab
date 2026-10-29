# Session 2 · Lab 2: How busy is r1's link to pc1?

**Pairs** · 20 minutes · outcome: A rate in kbit/s, with the calculation

Run everything from this session's folder: `cd s02`

## Terminal 1: nms · terminal 2: traffic

```sh
# nms: find the index of eth1 on r1
snmpwalk -v2c -c public 172.30.30.2 IF-MIB::ifDescr | grep eth

# terminal 2: 10 pings per second, 1200 bytes each
docker exec clab-mdh-pc1 ping -q -c 300 -i 0.1 -s 1200 10.2.0.10

# nms: two readings, 10 seconds apart (use your index)
snmpget -v2c -c public -Oqv 172.30.30.2 IF-MIB::ifHCInOctets.59
sleep 10
snmpget -v2c -c public -Oqv 172.30.30.2 IF-MIB::ifHCInOctets.59
```

Prints something like:

```sh
13890
153148     # (153148 - 13890) × 8 / 10 s ≈ 111 kbit/s
```

## Then verify

Work out what the rate should be: 10 packets/s × about 1240 bytes. Is your SNMP number close? Why not exact?
