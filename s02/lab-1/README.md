# Session 2 · Lab 1: Deploy the lab and ask r1 who it is

**Individual** · 10 minutes · outcome: r1's name, location and contact

Run everything from this session's folder: `cd s02`

## In the Codespaces terminal

```sh
git pull && cd s02                      # today's files
sudo containerlab destroy -a            # stop last week's lab
sudo containerlab deploy -t s02-mgmt.clab.yml
docker exec -it clab-mdh-nms sh         # a shell on nms

snmpwalk -v2c -c public 172.30.30.2 system
```

Prints something like:

```sh
SNMPv2-MIB::sysName.0 = STRING: r1
SNMPv2-MIB::sysLocation.0 = STRING: MDH-Net lab, rack 2
SNMPv2-MIB::sysContact.0 = STRING: noc@mdh-net.example
```

## Then verify

Now ask srv (172.30.30.3) the same. Then try `-c private` instead of `-c public`: what happens, and why?
