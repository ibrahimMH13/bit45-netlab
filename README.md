# BIT 4.5 B Network Management · lab

One folder per session (`s01`, `s02`, …), one README per task inside it.
Start each session with `git pull`, then `cd sNN`.

## Option A · In the browser (GitHub Codespaces)

Code → Codespaces → Create codespace on main. Nothing to install.

## Option B · On your own laptop

You need **Docker Desktop** (running) and **VS Code** with the
**Dev Containers** extension.

1. `git clone` this repo and open the folder in VS Code.
2. When VS Code asks, choose **Reopen in Container** (or press F1 →
   "Dev Containers: Reopen in Container"). The first time downloads about 1 GB.
3. Use the terminal inside VS Code, exactly as in Codespaces.

## Opening Grafana and Prometheus (sessions 3 and 4)

After `sudo containerlab deploy …`, open the **PORTS** tab in VS Code:

| Port | What | Open |
|---|---|---|
| 3000 | Grafana (no login) | globe icon next to the port |
| 9090 | Prometheus | globe icon next to the port |

On your laptop the address is `http://localhost:3000`. If another program
already uses 3000, VS Code picks a different local port; the PORTS tab
shows which one. If a port is missing from the list: **Add port** → type it.

## Known differences on a laptop

- Session 4, task 3: Docker Desktop's Linux kernel has no `fq_codel`. If
  `./apply.sh` prints `No such file or directory`, use `sfq` instead
  (same line, other name). Everything else works the same.
- Give Docker Desktop at least 4 GB of memory (Settings → Resources).
