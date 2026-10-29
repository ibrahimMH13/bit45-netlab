# Session 1 · Lab 2: Why can pc1 not reach the portal?

**Pairs** · 20 minutes · outcome: The portal answers with HTTP 200

Run everything from this session's folder: `cd s01`

## Try, fix, try again

```sh
alias pc1='docker exec -it clab-mini-pc1'
alias srv='docker exec -it clab-mini-srv'
pc1 ping -c 2 10.1.0.1      # the router: works
pc1 ping -c 2 10.2.0.10     # the portal: fails. Why?
# tell each side where the other network is
pc1 ip route add 10.2.0.0/24 via 10.1.0.1
srv ip route add 10.1.0.0/24 via 10.2.0.1
pc1 curl -s -o /dev/null -w '%{http_code}\n' http://10.2.0.10
```

Prints something like:

```sh
200
```

## Then verify

Before adding the routes, write one sentence: why does the ping fail? Then `pc1 ip route` and check your answer.
