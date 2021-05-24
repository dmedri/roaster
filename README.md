# roaster

![](images/roaster-logo.png)

## Introduction

This project is an attempt to design a new tiny tool to support 
[**R**](http://www.r-project.org), its users (**statisticians**, **data
scientists**) and **sysadmins**. It is an independent project, there is
no relationship with the R Foundation.

Basic features:

* get the latest R stable release;
* build sources:
	* for a _standard installation_;
	* for a _server solution_;
	* for a _virtual environments_.

_Virtual Environments_ are for special deployments in user-space. The
reference is Python virtualenv, and the goal is replicate _as-close-as-we-can_ its main features.

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
First test: build a Virtual Environment:

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

## Support

How to create *virtual environments*:

* [Virtual environments in user space](docs/build-virtualenv.md)
* [Customizable options](docs/build-virtualenv-options.md)

How to make a *standard installation*:

* [Standard installation in your system](docs/build-standard.md)
* [Customizable options](docs/build-standard-options.md)

How to prepare a *server solution*:

* [Server installation in your system](docs/build-server.md)
* [Customizable options](docs/build-server-options.md)

## For developers only

*Since the release v0.13*, SVN repositories are supported. It's actually a "hidden" feature,
 command line options not shown.

```{bash}
$ ./roaster --setup
```

 * with `RBTYPE="stable"` you get latest stable release (e.g. "R-3.6.3");
 * with `RBTYPE="branch"` you get the stable svn branch (e.g. "R-3-6-branch", stable + patches);
 * with `RBTYPE="trunk"` you get the trunk svn repository.


```{bash}
$ ./roaster --build-virtualenv
```

With SVN repositories, either "branch" or "trunk", the first run is a `svn checkout`, you 
fetch all the sources available. Next times, with new builds, the local repositories will 
be updated.

Fetch latest n repos (optional):

```{bash}
$ ./roaster --svn-repo-fetch-all
```

Update all the local svn repos (optional):

```{bash}
$ ./roaster --svn-repo-update-all
```

List informations about the latest n repos:

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
