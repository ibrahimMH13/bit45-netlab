#!/bin/sh
# r1 eth2 = MDH-Net's uplink: 50 Mbit/s, like the real contract with the ISP.
# ./apply.sh runs this file on r1. Undo your edits: git checkout config/r1/qos.sh
set -e
tc qdisc del dev eth2 root 2>/dev/null || true

# The line: everything leaving eth2 is held to 50 Mbit/s (HTB = a shaper).
tc qdisc add dev eth2 root handle 1: htb default 10
tc class add dev eth2 parent 1:  classid 1:1  htb rate 50mbit
tc class add dev eth2 parent 1:1 classid 1:10 htb rate 50mbit ceil 50mbit

# The queue in front of the line: one FIFO, 3 MB (= 0.48 s at 50 Mbit/s).
# Task 3: first make this queue smaller, then replace it with fq_codel.
tc qdisc add dev eth2 parent 1:10 bfifo limit 3000000

# Task 4: a second class for bulk traffic (DSCP CS1), 20 Mbit/s, plus a filter.
