#!/usr/bin/env bash
# Session 1, lab 3: plant one hidden fault in the mini MDH-Net lab.
#
#   ./break.sh            break something at random (your partner does not look)
#   ./break.sh 3          plant fault 3 on purpose
#   ./break.sh --check    is the portal reachable from pc1?
#   ./break.sh --fix      undo every fault (the lab goes back to lab-2 state)
#   ./break.sh --key      print the answer key
#   ./break.sh --selfcheck  teacher: prove every fault breaks and every fix heals
#
# Needs the lab deployed and lab 2 done (routes added on pc1 and srv).
# Works on the session 1 lab (mini) and the session 2 lab (mdh).
set -u
L=$(docker ps --format '{{.Names}}' | grep -q '^clab-mdh-' && echo mdh || echo mini)
x() { docker exec "clab-$L-$1" sh -c "$2" >/dev/null 2>&1; }

FAULTS=(
  "r1: interface eth2 (towards srv) is shut down"
  "r1: IP forwarding is switched off, so it no longer routes"
  "srv: its route back to 10.1.0.0/24 is deleted"
  "r1: 40% packet loss on eth1 (towards pc1)"
  "srv: wrong IP address, 10.2.0.11 instead of 10.2.0.10"
  "srv: the web server (nginx) is stopped; ping still works"
)

plant() {
  case "$1" in
    1) x r1 "ip link set eth2 down" ;;
    2) x r1 "sysctl -w net.ipv4.ip_forward=0" ;;
    3) x srv "ip route del 10.1.0.0/24" ;;
    4) x r1 "tc qdisc add dev eth1 root netem loss 40%" ;;
    5) x srv "ip addr del 10.2.0.10/24 dev eth1; ip addr add 10.2.0.11/24 dev eth1; ip route add 10.1.0.0/24 via 10.2.0.1" ;;
    6) x srv "pkill nginx" ;;
    *) echo "no fault $1 (1-${#FAULTS[@]})"; exit 1 ;;
  esac
}

fix() {
  x r1 "ip link set eth2 up"
  x r1 "sysctl -w net.ipv4.ip_forward=1"
  x r1 "tc qdisc del dev eth1 root"
  x srv "ip addr del 10.2.0.11/24 dev eth1"
  x srv "ip addr add 10.2.0.10/24 dev eth1"
  x srv "ip route replace 10.1.0.0/24 via 10.2.0.1"
  x srv "pgrep nginx || nginx"
  x pc1 "ip route replace 10.2.0.0/24 via 10.1.0.1"
}

check() {
  if docker exec "clab-$L-pc1" sh -c "ping -q -c 10 -i 0.2 -W 1 10.2.0.10 | grep -q ' 0% packet loss' && curl -s -m 2 -o /dev/null http://10.2.0.10"; then
    echo "portal OK from pc1"
  else
    echo "portal NOT reachable from pc1"; return 1
  fi
}

case "${1:-}" in
  --fix)   fix; check ;;
  --check) check ;;
  --key)   for i in "${!FAULTS[@]}"; do echo "$((i + 1)). ${FAULTS[$i]}"; done ;;
  "")      fix; n=$((RANDOM % ${#FAULTS[@]} + 1)); plant "$n"
           echo "A fault is planted. Hand over to your partner." ;;
  --selfcheck)  # every fault must break the portal, and --fix must restore it
           for i in "${!FAULTS[@]}"; do
             fix; plant $((i + 1))
             if check >/dev/null; then echo "FAIL: fault $((i + 1)) not detected"; exit 1; fi
             fix; check >/dev/null || { echo "FAIL: fix after fault $((i + 1))"; exit 1; }
             echo "ok  fault $((i + 1))"
           done ;;
  *)       fix; plant "$1"; echo "fault $1 planted" ;;
esac
