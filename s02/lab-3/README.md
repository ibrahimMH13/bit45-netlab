# Session 2 · Lab 3: How busy is r1's link to pc1?

**Pairs** · 15 minutes · outcome: A rate in kbit/s, with the calculation

Run everything from this session's folder: `cd s02`

## Terminal 1: nms · terminal 2: traffic

```sh
docker exec -it clab-mdh-nms sh         # terminal 1: a shell on nms
snmpwalk -v2c -c public 172.30.30.2 IF-MIB::ifDescr | grep eth
# terminal 2: 10 pings per second, 1200 bytes each, for 30 s
docker exec clab-mdh-pc1 ping -q -c 300 -i 0.1 -s 1200 10.2.0.10
# terminal 1: two readings, 10 s apart (use your index)
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

Work out what the rate should be: 10 packets/s × about 1240 bytes × 8. Is your SNMP number close? Why not exact?
