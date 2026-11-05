# Session 3 · Lab 1: Deploy the stack and find the first number

**Individual** · 10 minutes · outcome: Prometheus and Grafana open; one target up

Run everything from this session's folder: `cd s03`

## In the Codespaces terminal

```sh
git pull && cd s03                      # today's files
sudo containerlab destroy -a            # stop last week's lab
sudo containerlab deploy -t s03-mon.clab.yml
# PORTS tab → 9090 (Prometheus) → open in browser
#   Status → Target health: how many targets?
#   Query: type  up  then  probe_success  → Execute
# PORTS tab → 3000 (Grafana) → open in browser
```

Prints something like:

```sh
up{instance="http://10.2.0.10", job="portal-http"}  1
probe_success{instance="http://10.2.0.10", ...}  1
```

## Then verify

Open `config/prom/prometheus.yml`. Which address does Prometheus scrape for the job portal-http, and which address does the probe test?
