# roaster

![](../images/roaster-logo.png)

## Getting started

The following informations help you to have a stable running
R environment using the Roaster.

First of all, install the tool:

```bash
$ git clone https://github.com/dmedri/roaster/
$ cd roaster/
$ ./roaster --help
```

![](images/roaster-terminal-help.png)

If you can see the help menu, the tool is available and running.

By default, the "stable" environment is set and you don't need any
other action before the build. To set a different release:

```bash
$ ./roastger --set-branch
```

for the "branch" (stable, from SVN server) version, or

```bash
$ ./roaster --set-trunk
```
for the "trunk" (unstable) version of R environment.

## Build

In build step, there're 3 options:

```bash
$ ./roaster --build-standard
```

The most classical installation you can do in a Unix-like system.
Binaries and needed libraries will be placed in the three, shared with all
users.

To try a different build, with a local installation in $HOME space, with
feature close to Python virtualenv, can run the following command:

```bash
$ ./roaster --build-virtualenv
```

_Last but not least_, the option to build a server configuration that
fit in the system path-three, and can live concurrently with other release.

```bash
$ ./roaster --build-server
```

You could run the whole set of these options, building and using 3 kind of
installations. An ex-post command at this point is:

```bash
$ ./roaster --status
```

Ready to go.
