# Session 4 · Lab 1: Deploy, then measure idle and at 18:00

**Individual** · 15 minutes · outcome: Ping RTT idle and under load, upload Mbit/s

Run everything from this session's folder: `cd s04`

## In the Codespaces terminal

```sh
git pull && cd s04
sudo containerlab destroy -a          # stop last week's lab
sudo containerlab deploy -t s04-perf.clab.yml
./measure.sh idle                     # ping only: the baseline
./measure.sh                          # the 18:00 upload + ping
# PORTS tab → 3000 → Grafana opens on 'MDH uplink'
#   run ./measure.sh again and watch the two top panels
```

Prints something like:

```sh
rtt min/avg/max/mdev = 0.056/0.155/0.271/0.041 ms
rtt min/avg/max/mdev = 244.6/433.5/1251.0/142.8 ms
upload: [SUM]  0.00-24.48 sec  138 MBytes  47.3 Mbits/sec
```

## Then verify

Write both averages down. How many times slower is the ping under load, and was a single packet lost?
