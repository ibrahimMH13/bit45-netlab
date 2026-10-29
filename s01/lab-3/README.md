# Session 1 · Lab 3: Find your partner's hidden fault

**Pairs, swap roles** · 30 minutes · outcome: Two faults found, each in one sentence

Run everything from this session's folder: `cd s01`

## Partner A breaks, partner B fixes

```sh
./break.sh          # A plants a fault, B looks away
# B: find it with ping, traceroute, ip, curl,
#    write down device + cause, fix it by hand
./break.sh --check  # B proves the fix
./break.sh --fix    # stuck after 10 min? reset
# swap roles and repeat
```

Prints something like:

```sh
portal OK from pc1
```

## Then verify

For each fault, write: the symptom, the command that showed where it was, and the fix.
