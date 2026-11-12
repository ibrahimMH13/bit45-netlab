# Session 4 · Lab 4: Give the 18:00 sync its own 20 Mbit/s class

**Individual** · 25 minutes · outcome: CS1 upload ≈ 19 Mbit/s, the rest ≈ 30

Run everything from this session's folder: `cd s04`

## Config/r1/qos.sh · what to add

```sh
# 1:10 default class: rate 30mbit ceil 50mbit prio 0
# 1:20 bulk class:    rate 20mbit ceil 20mbit prio 1
tc class add dev eth2 parent 1:1 classid 1:20 \
   htb rate 20mbit ceil 20mbit prio 1
# one fq_codel under each class
# CS1 → 1:20 (DSCP 8 = ToS byte 0x20):
tc filter add dev eth2 parent 1: protocol ip \
   u32 match ip dsfield 0x20 0xfc flowid 1:20
```

## Apply and measure

```sh
./apply.sh
./measure.sh cs1   # marked upload
./measure.sh both  # marked + unmarked
docker exec clab-mdh-r1 \
  tc -s class show dev eth2
```

Prints something like:

```sh
upload CS1: ... 19.4 Mbits/sec
upload unmarked: ... 29.7 Mbits/sec
```

## Then verify

Change the bulk class to `ceil 50mbit` and run `./measure.sh cs1` and `./measure.sh both` again. What does each upload get now, and why?
