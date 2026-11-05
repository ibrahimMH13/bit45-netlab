# Session 3 · Lab 5: Write two alerts and make one fire

**Individual** · 20 minutes · outcome: PortalDown seen pending, then firing

Run everything from this session's folder: `cd s03`

## Write the rules, reload, break the portal

```sh
# 1. config/prom/rules.yml: PortalDown (previous slide) and
#    PortalLossy: avg_over_time(probe_success{job="portal-icmp"}[1m]) < 0.9
#    for: 30s, severity: ticket
# 2. prometheus.yml: uncomment rule_files
./reload.sh
./break.sh 6              # stop nginx on srv
# Prometheus → Alerts: watch PortalDown for 30 s
./break.sh --fix
```

Prints something like:

```sh
SUCCESS: 2 rules found
PortalDown  pending → firing  (severity=page)
```

## Then verify

Plant fault 4 (`./break.sh 4`). Which alert fires, after about how long, and why is it slower than PortalDown?
