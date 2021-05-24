# roaster

![](images/roaster-logo.png)

## Introduction

This project is an attempt to design a new tiny tool to support 
[**R**](http://www.r-project.org), its users (**statisticians**, **data
scientists**) and **sysadmins**. It is an independent project, there is
no relationship with the R Foundation.

Basic features:

* get the latest R stable release;
* build source code:
	* for a _standard installation_;
	* for a _server solution_;
	* for _virtual environments_.
* update.

_Virtual Environments_ are for special deployments in user-space. The
reference is Python virtualenv, and the goal is replicate _as-close-as-we-can_ its main features.

Advanced features:

* get source code from SVN repositories:
	* clone and update latest 2 stable branches;
	* clone and update R-TRUNK.
* build source code with the same options seen above.


## Basic usage

Installation:

```{bash}
$ git clone https://github.com/dmedri/roaster/
$ cd roaster/
$ ./roaster --help

Roaster - https://github.com/dmedri/roaster
Copyright 2019-2021 Daniele Medri - GNU LGPL 2.1+
Use 'roaster --help' for the available options.

Get informations about R and mirrors:
	--status         	R status (online + local)

Basic administration:
	--setup          	Open roaster config file.
	--mirrors        	Show mirrors by-country.
	--autoclean      	Remove unuseful files.
	--factory-reset  	Factory reset.

Build source code:
	--build-settings  	Show build settings.
	--build-server    	Concurrent minimal versions in system.
	--build-standard  	Common installation in system.
	--build-virtualenv	Create a virtual environment.

SVN actions:
	--svn-repo-fetch-all	Fetch svn repos (latest 2 stable + trunk).
	--svn-repo-update-all	Update local svn repos (in ~/.roaster/src/).
	--svn-repo-branches	Basic infos about branches.

```

First test: build a virtual environment (`--build-virtualenv`).

```{bash}
$ ./roaster --build-virtualenv

Roaster - https://github.com/dmedri/roaster
Copyright 2019-2021 Daniele Medri - GNU LGPL 2.1+
Use 'roaster --help' for the available options.

Contacting online resources...

Running Linux.

1) Dependencies already available.
2) The source code is already available.
	   Type: stable (4.1.0)
	Sources: /home/dmedri/.roaster/src/R-4.1.0
	  Build: Virtual Environment (in userspace)
	  Tests: none
	   Logs: /home/dmedri/.roaster/logs/35435.build (file)
	Options:
		--without-recommended-packages
		--enable-R-shlib
Are you ready to start? (y/n)

```
Easy.

# Build details and defaults

By design, the `Roaster` has its own defaults optimized for generalized use
cases. The latter don't need to be customized by an end-user, but it can be useful to
know them. The app has its own configuration file (``~/.roaster/config`) that can be 
opened with a common text editor or the specific option (see. `--setup`). To
show the build settings run:

```{bash}
$ ./roaster --settings
```

The configuration file is changed over time and could change with new incoming features.
A factory reset it's always a good solution to clean temporary files and store
the needed files (see. `--factory-reset`).

## Make and configure defaults

By design, we could change the `configure` options for every build type. To do
that, open up the configuration file and change the default accordingly to your
specific needs.

```{bash}
$ ./roaster --setup
```

Search `OPTSTD` for the standard build.

```
--enable-R-shlib
```

Search `OPTSRV` for the server build.

```
--without-recommended-packages
--enable-memory-profiling
--enable-R-shlib
--with-blas
--with-lapack
--without-tcltk
```

Search `OPTRVE` for the virtualenv build. Default:

```
--without-recommended-packages
--enable-R-shlib
```

While some options change the features set at low level (eg. the Java support,
optional), the recommended packages could be always installed in a second-time.

Note: take care that all options will be a one-line configuration set.

## Caching objects at build time

_To be written..._

## Available options

As you already seen above in the example session or you'll see in the app menu, 
there're tree kind of deploypment:

* standard build (`--build-standard`);
* server build (`--build-server`);
* virtualenv (`--build-virtualenv`).

### Build: standard configuration

```{bash}
$ ./roaster --build-standard
```
_To be written_

The default destination will be `/usr/local`.

### Build: server configuration

```{bash}
$ ./roaster --build-server
```
_To be written_

The default destination will be `/opt/R/`.

### Build: virtual environments

A first-time feature -- already available in the Python world -- 
was the concept of _virtual environment_. Our attempt is to mimic 
some nice ideas for modern scenarios (eg. containers, VMs). The 
acronym RVE stands for _R Virtual Environment_.

```{bash}
$ ./roaster --build-virtualenv
```

The end result is in `~/RVE`, a directory with the `R` environment and the
basic tools to work.

To enable it:

```{bash}
$ cd
$ source RVE/bin/activate
```

You'll see a new prompt:

```{bash}
(RVE) dmedri@host:~$
```

If you browse the content of the new environment, you'll see some directories
within: `bin/`, `lib/` and `share/` (for `R`) and a `workspace/` one for your
work. Now run the following:

```{bash}
(RVE) dmedri@host:~$ R
```

When you leave `R`, restore everything with:

```{bash}
(RVE) dmedri@host:~$ deactivate
```

and you switch back to your HOME directory.

Note: the _virtualenv_ option is in-development and need love.

## Advanced features (for developers)

By design, the `Roaster` was for end-users needs on stable `R` release.
Handling SVN repositories is a recent feature to support an advanced use case,
mainly designed for developers than need special options for their work. In
other terms, the default is the `R` release code base, that could be changed
with an option in the configuration file:

```{bash}
$ ./roaster --setup
```

Search the `RBTYPE` (aka _R Build Type_) option:

 * `RBTYPE="stable"` will get latest stable release (e.g. "R-4.1.0", *default*);
 * `RBTYPE="branch"` will get the stable release SVN branch (e.g. "R-4-1-branch");
 * `RBTYPE="trunk"` will get the SVN repository for R-TRUNK.

Edit, save and exit.

Now, you can use the well-known build options described above, using
SVN repositories by default.

### SVN menu options

With SVN repositories, either "branch" or "trunk", the first run will fetch all the
needed SVN file from the repository. Next builds, get updates for local repositories.

Fetch latest _n_ repos (optional):

```{bash}
$ ./roaster --svn-repo-fetch-all
```

Update local svn repositories (optional):

```{bash}
$ ./roaster --svn-repo-update-all
```

List informations about latest _n_ repositories:

```{bash}
$ ./roaster --svn-repo-branches
```

## Supported platforms

The `roaster` is a GNU Bash script, a text file that run on almost all modern
GNU/Linux distributions. 

Tested on the following Linux distros:
* Debian-derivatives;
* RedHat-derivatives;
* Arch-derivatives;
