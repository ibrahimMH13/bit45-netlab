# Session 2 · Lab 3: Last week's faults, seen only from nms

**Pairs, swap roles** · 30 minutes · outcome: Device, cause and the OID that showed it

Run everything from this session's folder: `cd s02`

## A breaks, B looks only from nms

```sh
cd s02 && ./break.sh   # A, in a second terminal
# B, inside nms. Wait 30 s: the agent caches.
S='snmpwalk -v2c -c public'
$S 172.30.30.2 IF-MIB::ifOperStatus      # links up?
$S 172.30.30.2 IP-MIB::ipForwarding      # routing on?
$S 172.30.30.3 IP-MIB::ipAdEntAddr       # addresses
$S 172.30.30.3 IP-FORWARD-MIB::ipCidrRouteNextHop
$S 172.30.30.3 HOST-RESOURCES-MIB::hrSWRunName
./break.sh --check  # A's terminal: after B names + fixes it
```

Prints something like:

```sh
IP-MIB::ipForwarding.0 = INTEGER: notForwarding(2)
```

## Then verify

One fault of the six cannot be seen with SNMP at all. Which one, and what would you need to see it?
