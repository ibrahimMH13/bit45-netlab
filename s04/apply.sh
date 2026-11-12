#!/usr/bin/env bash
# Run config/r1/qos.sh on r1 (r1 sees it as /etc/lab/qos.sh), then show the
# queues on the uplink. If the script fails, r1 may be left without shaping:
# fix the line it names and run ./apply.sh again.
set -e
docker exec clab-mdh-r1 sh /etc/lab/qos.sh
docker exec clab-mdh-r1 tc qdisc show dev eth2
docker exec clab-mdh-r1 tc class show dev eth2
