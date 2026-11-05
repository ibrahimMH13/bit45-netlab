# Session 3 · Lab 6: Find the fault from the dashboard alone

**Pairs, swap roles** · 25 minutes · outcome: Fault named from dashboard, alerts and SNMP

Run everything from this session's folder: `cd s03`

## A breaks, B uses only Grafana and Prometheus

```sh
./break.sh             # A, in the terminal; B does not look
# B: dashboard first. Which panel moved? Which alert fires?
# B: then device data, in Prometheus → Query:
ifOperStatus{ifName=~"eth."} == 2      # any link down?
rate(ifHCInOctets{ifName=~"eth."}[1m])*8  # where does traffic stop?
# B names device + cause; A checks:
./break.sh --check     # then --fix, swap roles
```

Prints something like:

```sh
ifOperStatus{instance="172.30.30.2", ifName="eth2", ...}  2
```

## Then verify

Last week SNMP could not see fault 4. Which panel shows it today, and why can the probe see what SNMP could not?
