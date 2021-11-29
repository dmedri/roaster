# roaster

![](images/roaster-logo.png)

## Introduction

This project is an attempt to design a new tiny tool to support 
[**R**](http://www.r-project.org), helps its users (**statisticians**, **data
scientists**) and **sysadmins**. It's an independent project, with
no relation to the R Foundation.

The `roaster` file is a GNU Bash script, a text file that run on almost 
all modern GNU/Linux distributions. Tested on the following Linux distros:

* Debian-derivatives;
* RedHat-derivatives;
* Arch-derivatives;

Basic features:

* get the latest R stable release;
* build source code:
	* for a _standard installation_;
	* for a _server solution_;
	* for _virtual environments_.
* get regular updates.

_Virtual Environments_ are new deployments in user-space, the
reference is Python virtualenv and the goal is replicate _as-close-as-we-can_ its main features.

Advanced features:

* get source code from SVN repositories:
	* clone and update latest 2 stable branches;
	* clone and update R-TRUNK.
* build source code with the same options seen above.

---

## Basic usage

Installation:

```bash
$ git clone https://github.com/dmedri/roaster/
$ cd roaster/
$ ./roaster --help
```

```
Roaster - https://github.com/dmedri/roaster
Copyright 2019-2021 Daniele Medri - GNU LGPL 2.1+
Use 'roaster --help' for the available options.

Get informations:
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

```bash
$ ./roaster --build-virtualenv
```

```
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

## Build details and defaults

By design, the `Roaster` has its own defaults optimized for generalized use
cases. The latter don't need to be customized by an end-user, but it can be useful to
know them. The app has its own configuration file (`~/.roaster/config`) that can be 
opened with a common text editor or the specific option (see. `--setup`). Type
the following command:

```bash
$ ./roaster --build-settings
```

A factory reset it's always a good solution to clean temporary files and store
the needed files (see. `--factory-reset`).

### Make and configure defaults

The `configure` options can be customized for custom builds.

```bash
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

While some options could change the features set at low level (eg. the Java support,
optional), the recommended packages could be always installed in a second-time.

Note: take care that all options will be a one-line configuration set.

### Caching objects at build time

By design, `ccache` is installed by default. This is a compiler cache that speeds up 
recompilation by caching the result of previous compilations and detecting when the 
same compilation is being done again. Supported languages are C, C++, Objective-C and
Objective-C++. It's useful to build R source code and new packages.

For _standard_ and _server_ builds, you'll have a directory in your HOME,
`~/.ccache`, and a configuration file within, `ccache.conf`, with the following
settings:

```
# Roaster - 'ccache' configuration
# in ~/.ccache/ccache.conf
max_size = 5.0G
sloppiness = include_file_ctime
hash_dir=false
```

Virtual environments get the same files in their own directories, usually
`~/RVE`. Existing configurations are for general use-cases but can be customized.

### Available options

As you already seen above in the example session above, or you'll see in the app menu, 
there're tree kind of deployments:

* standard (`--build-standard`);
* server (`--build-server`);
* virtualenv (`--build-virtualenv`).

#### Build: standard configuration

```bash
$ ./roaster --build-standard
```
The _standard_ build is the most general configuration of your R environment,
quite close to the official distributed binaries. The default destination for
files is usually in `/usr/local` -- for Linux systems.

Everytime you'll build
sources the resulting files (binaries, docs and so on) will overwrite the previous
installation. For the most updated release could be okay, but if you
need to maintain many R releases for production use-cases, the _server_ build
is the answer.

#### Build: server configuration

```bash
$ ./roaster --build-server
```
The _server_ build is for production use-cases and one feature over all is the
concurrent installation. It's a special case deployment reserved to developers 
and sysadmins.

The default destination will be `/opt/R/`, by-release version. Directories (eg. 
`/opt/R/R-4-1-BRANCH`) will collect all the needed files **and** a copy of the 
source code -- to re-build and/or customize the stable three. For the extended 
case of SVN repos, you could still update the available objects with `svn update` 
in the source three.

Binaries are not executable by default, their paths should be appended to the 
PATH envar and access need administrave rights.

#### Build: virtual environments

A killer feature -- a concept already available in the Python world -- 
are the support for _virtual environments_. Our attempt is to mimic 
some nice ideas looking at modern scenarios (eg. containers, VMs). RVE 
means _R Virtual Environment_.

```bash
$ ./roaster --build-virtualenv
```

The end result is in `~/RVE`, a directory with the `R` binaries and the
basic tools to work.

To enable it:

```bash
$ cd
$ source RVE/bin/activate
```

You'll see a new prompt:

```bash
(RVE) dmedri@host:~$
```

If you browse the content of the new location, you'll see some 
directories: `bin/`, `lib/` and `share/` (for `R`) and a `workspace/` 
 for your work. Now run the following:

```bash
(RVE) dmedri@host:~$ R
```

When you leave `R`, restore everything with:

```bash
(RVE) dmedri@host:~$ deactivate
```

and you switch back to your HOME directory.

Note: the _virtualenv_ option is in-development and need love.

---

## Advanced features (for developers)

Originally, the _Roaster_ was designed to end-users, and latest `R` stable release.
Handling SVN repositories is a new feature to support an advanced use case,
mainly designed for developers than need special options for their work. In
other terms, the default is the `R` release code base, but could be changed
with an option-value in the configuration file:

```bash
$ ./roaster --setup
```

Search the `RBTYPE` (aka _R Build Type_) option:

 * `RBTYPE="stable"` will get latest stable release (e.g. "R-4.1.0", *default*);
 * `RBTYPE="branch"` will get the stable release SVN branch (e.g. "R-4-1-branch");
 * `RBTYPE="trunk"` will get the SVN repository for R-TRUNK.

Edit, save and exit.

Now, you can use the well-known build options described above, using
SVN repositories.

### SVN menu options

With SVN repositories, either "branch" or "trunk", the first run will fetch all the 
files. Local updates are the next step.

Fetch latest 2 repositories (optional):

```bash
$ ./roaster --svn-repo-fetch-all
```

Update local svn repositories (optional):

```bash
$ ./roaster --svn-repo-update-all
```

List informations about latest 3 repositories:

```bash
$ ./roaster --svn-repo-branches
```
