#!/usr/bin/env bash
# The 18:00 test: pc1 uploads at full speed (like cloud sync) while a user's
# ping measures the delay over the same uplink. Same test before and after.
#
#   ./measure.sh          upload (4 TCP streams) + ping, 20 s
#   ./measure.sh idle     ping only: the baseline
#   ./measure.sh cs1      the upload marked DSCP CS1 (bulk), + ping
#   ./measure.sh both     a CS1 upload and an unmarked one at once, + ping
set -u
P="docker exec clab-mdh-pc1"
up() {  # $1 = port, $2 = extra iperf3 options, $3 = log file
  $P sh -c "iperf3 -c 10.2.0.10 -p $1 -t 24 -P 4 $2 > $3 2>&1" &
}
case "${1:-}" in
  idle) ;;
  cs1)  up 5201 "--dscp CS1" /tmp/a.txt ;;
  both) up 5201 "--dscp CS1" /tmp/a.txt; up 5202 "" /tmp/b.txt ;;
  "")   up 5201 "" /tmp/a.txt ;;
  *)    echo "usage: ./measure.sh [idle|cs1|both]"; exit 1 ;;
esac
[ "${1:-}" = idle ] || sleep 3   # let the upload fill the queue first
echo "ping pc1 -> srv, 20 s:"
$P ping -q -c 40 -i 0.5 10.2.0.10 | tail -2
wait
show() { $P sh -c "grep 'SUM.*receiver' $1 || tail -3 $1" | awk -v n="$2" '{print n": "$0}'; }
case "${1:-}" in
  idle) ;;
  cs1)  show /tmp/a.txt "upload CS1" ;;
  both) show /tmp/a.txt "upload CS1"; show /tmp/b.txt "upload unmarked" ;;
  *)    show /tmp/a.txt "upload" ;;
esac
