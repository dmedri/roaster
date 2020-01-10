# roaster

## Virtual Environment

Roaster was born with a simple idea: create a RVE (R Virtual
Environment), inspired by other existing solutions/scenarios.

Run the following command:

```bash
$ ./roaster --build-virtualenv
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
configure these settings editing `~/.roaster/config`. Every change
made here will be available next times.

4) If everything goes fine, the new directory `~/RVE` is created with
a set of infos and tools.

To enable it:

```bash
$ source RVE/bin/activate
```

The first visible change is the prompt:

```bash
(RVE) user@host:~$
```

It means that you "enabled" the virtual environment, or in other terms
that you changed HOME with `~/RVE` and the PATH has the new
`bin/` directory at the first place. Now you could run `R` command.

In this new HOME, `bin/`, `lib/` and `share/` host what is needed by R
to run. If you install new libraries, `lib/R/library/` will be the place.
The `workspace/` directory are simple convention, there to collect your
code.

Quitting the R session, the virtual environment is still there.
To leave that context, run `deactivate`:

```bash
(RVE) user@host:~$ deactivate
```

Everything will be restored to the previous setup.

--
Tested on Debian GNU/Linux 10. Fill issues for bugs or new features.
