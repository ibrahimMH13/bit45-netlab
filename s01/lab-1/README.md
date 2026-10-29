# Session 1 · Lab 1: Deploy the lab and find both networks

**Individual** · 15 minutes · outcome: A screenshot of the inspect table

Run everything from this session's folder: `cd s01`

## In the Codespaces terminal

```sh
cd s01
sudo containerlab deploy  -t s01-mini.clab.yml
sudo containerlab inspect -t s01-mini.clab.yml

# look inside pc1: which address is on which network?
docker exec -it clab-mini-pc1 ip -br addr show eth0
docker exec -it clab-mini-pc1 ip -br addr show eth1
```

Prints something like:

```sh
eth0@if55   UP   172.30.30.3/24   <- management
eth1@if56   UP   10.1.0.10/24     <- data
```

## Then verify

Your inspect table shows three nodes in state 'running'. Your eth0 address may differ; eth1 must be 10.1.0.10.
