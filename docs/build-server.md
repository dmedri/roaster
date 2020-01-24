# roaster

## Build a server solution

In production stage, services need to run with any stop. The server
build support multiple versions of R concurrently, a downsized release
without unneeded features (eg. X, tcltk) and the right settings to
work.

Run the following command to start:

```bash
$ roaster --build-server
```

What happens:

1) first of all, `roaster` do some checks for build dependencies,
in other terms install the needed packages for the task, for your
specific Os. In some cases (eg. Debian GNU/Linux) is automatic. In
other cases you need some hacks before. Any feedback is welcome. 

2) the second goal is prepare the source code of the latest stable
R release. If not already available in `~/.roaster/src` it will be
downloaded. The archive will be decompressed in the same place.

3) the `./configure` step will append the available options. You can
customize these settings editing `~/.roaster/config`. Every change
made here will be available next times.

4) If everything goes fine -- at the end of the `make` step -- it's
time to install. Versions will be installed in the same directory
(by default `/opt/R/`).

```bash
$ ls /opt/R/
3.5.2
3.6.2
```

---
Tested on Debian GNU/Linux 10. Fill issues for bugs or new features.
