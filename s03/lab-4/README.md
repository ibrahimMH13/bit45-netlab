# Session 3 · Lab 4: Build the portal dashboard in Grafana

**Individual** · 25 minutes · outcome: A saved dashboard with four panels

Run everything from this session's folder: `cd s03`

## In Grafana (port 3000)

1. Connections → Data sources → Add → Prometheus. URL `http://172.30.30.30:9090` → Save & test.
2. Dashboards → New → Add visualization → your Prometheus.
3. Paste a query (Code mode), set title and unit (Standard options → Unit).
4. Add the other three panels. Save as 'MDH portal'.

## The four queries

```sh
# 1 Up?   (Stat panel)
probe_success{job="portal-http"}
# 2 Latency   (unit: seconds)
probe_duration_seconds{job="portal-http"}
# 3 Ping loss   (unit: Percent 0.0-1.0)
1 - avg_over_time(
  probe_success{job="portal-icmp"}[1m])
# 4 Traffic r1   (unit: bits/sec)
rate(ifHCInOctets{instance="172.30.30.2",
  ifName=~"eth[12]"}[1m]) * 8
```

## Then verify

Run the ping from task 3 again. Which panels move, and which stay flat? Set the time range to 'Last 15 minutes', refresh 5s.
