# roaster

## Virtual Environment

Roaster was born with a simple idea: create a RVE (R Virtual
Environment), inspired by other existing solutions (eg. Python
virtualenv) and/or scenarios (eg. containers and VMs).

Run the following command:

```
$ ./roaster --build-virtualenv
```

What happens:

1) first of all, `roaster` do some checks for build dependencies,
in other terms install the needed packages for the task, for your
specific Os. In some cases (eg. Debian GNU/Linux) is automatic. In
other cases you need some hacks before. 

2) the second goal is prepare the source code of the latest stable
R release. If not already available in `~/.roaster/src` it will be
downloaded. The archive will be decompressed in the same place.

3) the `./configure` step will append the available options. You can
configure these settings editing `~/.roaster/config`. Every change
here will be available next times.

4) If everything goes fine, the new directory `~/RVE` is created with
a set of infos and tools.

To enable it:

```
$ source RVE/bin/activate
```

The first visible change is the prompt:

```
(RVE) user@host:~$
```
Now run:
```
(RVE) user@host:~$ R
```

It means that you "enabled" the virtual environment, or in other terms
that you changed HOME with `~/RVE` and the PATH has the new
`bin/` directory at the first place. Now you could run `R` command.

In this new HOME, `bin/`, `lib/` and `share/` host what is needed by R
to run. If you install new libraries, `lib/R/library/` will be the place.
The `workspace/` directory is a simple convention, there to collect your
code.

Quitting the R session, the virtual environment is still there.
To leave that context, run `deactivate`:

```
(RVE) user@host:~$ deactivate
```

Everything will be restored to the previous setup.
