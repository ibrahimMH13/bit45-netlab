#!/usr/bin/env bash
# Check config/prom/*.yml, then tell Prometheus to re-read them.
# Prometheus keeps running on the old config if the check fails.
set -e
docker exec clab-mdh-prom promtool check config /etc/prometheus/prometheus.yml
docker exec clab-mdh-prom wget -qO- --post-data= http://localhost:9090/-/reload
echo "reloaded: open the Targets page (Status → Target health)"
