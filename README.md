# roaster

Check R updates and build sources

## Introduction

This project is an attempt to design new deployments of R and
add new admin utilities.

Since the early bash prototypes there are some notable features:

* check info about the latest R stable release;
* show the status of your (system) R installations;
* retrieve, build and install latest release in two solutions:
	* a standard common build;
	* a virtual environment (flat-style) under user space.
## Usage

* Question: How many R installations are available in my system?
* Question: Are there some updated R releases?

```bash
$ roaster --check-status
```

* Question: What should I do to install latest R release in my system?

```bash
$ roaster --build-standard
```

* Question: What should I do to install latest R release as a virtual environment
in userspace?

```bash
$ roaster --build-virtualenv
```

Tested on Debian GNU/Linux 10. Fill issues for bugs or new features.
