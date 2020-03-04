# roaster

## A standard build

To build a standard R configuration in your system run the
following command:

```bash
$ roaster --build-standard
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

4) The default destination will be `/usr/local`.

5) if everything goes fine -- at the end of the `make` step -- it's
time to install. Roaster did some tests to avoid problems and will
ask you to procede or not in this step.

---
Tested on Debian GNU/Linux 10. Fill issues for bugs or new features.
