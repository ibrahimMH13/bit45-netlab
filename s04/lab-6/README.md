# Session 4 · Lab 6: Every change needs a way back

**Individual** · 10 min · outcome: roll back and prove it

Run everything from this session's folder: `cd s04`

```sh
git diff config/r1/qos.sh     # your change
cp config/r1/qos.sh ~/qos-mine.sh
git checkout config/r1/qos.sh # back to start
./apply.sh && ./measure.sh    # ≈ 434 ms again?
cp ~/qos-mine.sh config/r1/qos.sh
./apply.sh && ./measure.sh    # and back
```
