# roaster

![](images/roaster-logo.png)

## Introduction

This project is an attempt to design a new tiny tool to support 
[**R**](http://www.r-project.org), its users (**statisticians**, **data
scientists**) and **sysadmins**.

Basic features:

* get the latest R stable release;
* proceed with a _standard installation_;
* prepare a _server solution_;
* create _virtual environments_.

Virtual Environments are a new kind of R deployment in user-space. For
this specific case, the reference is Python virtualenv, and our goal is
replicate _as-close-as-we-can_ its main features.

## Basic usage

Installation:

```
$ git clone https://github.com/dmedri/roaster/
$ cd roaster/
$ ./roaster --help

Roaster - Check R updates and build sources.
Copyright 2019-2020 Daniele Medri - GNU LGPL 2.1+
Use 'roaster --help' for the available options.

Get informations about R and mirrors:
	--check-status   	Check available R releases.
	--mirrors    		View MIRRORS file.
	--mirrors-update    	Update mirrors list.

Basic administration:
	--autoclean      	Remove unuseful files.
	--factory-reset  	Factory reset.
	--settings       	Show settings.

Build source code:
	--build-server    	Concurrent minimal versions in system.
	--build-standard  	Common installation in system.
	--build-virtualenv	Create a virtual environment.
```
To build a Virtual Environment:

```
$ ./roaster --build-virtualenv
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

*Since the release v0.13* you can handle SVN repositories. It's actually a "hidden" feature,
 there's no command line argument, just set an option in `~/.roaster/config` file.
 
 * with `RBTYPE="stable"` you get latest stable release (e.g. "R-3.6.3");
 * with `RBTYPE="branch"` you get the stable svn branch (e.g. "R-3-6-branch", stable + patches);
 * with `RBTYPE="trunk"` you get the trunk svn repository.

To use these features, please remove the `~/.roaster` directory before the first run.

```
$ ./roaster-build-virtualenv

...
Branch R-3-6-branch available.
Local directory: R-3-6-BRANCH.
...
```
With SVN repositories, either "branch" or "trunk", the first run is a `svn checkout`, you 
fetch all the sources available. Next times, with new builds, the local repositories will 
be updated.

## Supported platforms

The `roaster` is text file that run on `bash`, the default shell on every
GNU/Linux distribution, and even the external commands used are tipically existing 
in Unix-like systems. Another good reason, is the needed software for our tasks.

When you try to build a mid-size project like R, your system is under pressure
and your CPUs will warm up like never before. This is why, ironically, we give this name 
to the project. The main `roaster` focus is get, configure and build source code, so all 
the necessary tools are required. If you care about performance, this is the *way*.

Summary:
* Debian-derivatives (*tested*). Main development is on Debian 10;
* RedHat-derivatives (*tested*, need help from its user-base);
* Arch-derivatives (*tested*, need help from its user-base);
* Other Linux distribution, need help from its user-base;
* FreeBSD is a good candidate with the "ports" system;
* MacOS is a good candidate with the "brew" system;
* MS-Windows, by-design really far.

## Notes for italian end-users

The `roaster` is used to test the R italian translation project, see. 
[R-italian-lang](https://github.com/dmedri/R-italian-lang). Use both repositories for your 
activities.
