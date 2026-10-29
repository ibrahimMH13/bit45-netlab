# Session 2 · Lab 1: Deploy the lab and see that nothing answers

**Individual** · 10 minutes · outcome: Three failures, each explained in one line

Run everything from this session's folder: `cd s02`

## In the Codespaces terminal

```sh
git pull && cd s02                      # today's files
sudo containerlab destroy -a            # stop last week's lab
sudo containerlab deploy -t s02-mgmt.clab.yml

docker exec clab-mdh-nms snmpget -v2c -c public 172.30.30.2 sysName.0
docker exec clab-mdh-nms ls /var/log/remote
docker exec clab-mdh-r1  chronyc sources
```

Prints something like:

```sh
Timeout: No Response from 172.30.30.2.
(empty)
506 Cannot talk to daemon
```

## Then verify

Open `config/r1/snmpd.conf` in the editor. Read the comments: they list what you will write in task 2.
