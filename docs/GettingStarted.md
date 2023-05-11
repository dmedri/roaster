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

The default environment is "stable" and you don't need any
other action before the build. Available options are:

```bash
$ ./roaster --set-branch
```

for the "branch" (stable, from SVN server) version of R environment. With
this option you could try the features of a stable release, with the incoming
patches that will be in for the next minor release.

```bash
$ ./roaster --set-trunk
```
for the "trunk" (unstable, from SVN server) version of R environment.
With this option you can try the incoming features that will be in the next
major release. Useful for developers, not for basic needs.

```bash
$ ./roaster --set-stable
```
To set up the "stable" environment.

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

You could run the whole set of these options, building and using the whole set.

At any time, you could see the status:

```bash
$ ./roaster --status
```

Ready to go.
