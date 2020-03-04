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

```bash
$ git clone https://github.com/dmedri/roaster/
$ cd roaster/
$ ./roaster --help

Roaster - Check R updates and build sources.
Copyright 2019-2020 Daniele Medri - GNU LGPL 2.1+
Use 'roaster --help' for the available options.

Get informations about R and mirrors:
	--check-status   	Check available R releases.
	--get-mirrors    	Update mirrors list.

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

```bash
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

---
Tested on Debian GNU/Linux 10. Fill issues for bugs or new features.
