# roaster

Check R updates and build sources

## Informations

This tool is a bash prototype with some notable features:

* check info about the latest R stable release;
* show the status of your (system) R installations;
* retrieve, build and install latest release in two solutions:
	* a standard common build;
	* a virtual environment (flat-style) under user space.
## Usage

Question: How many R installations are available in my system?
Question: Are there some updated R releases?

'''
$ roaster --check-status
'''

Question: What should I do to install latest R release in my system?

'''
$ roaster --build-standard
'''

Question: What should I do to install latest R release as a virtual environment
in userspace?

'''
$ roaster --build-virtualenv
'''

Tested on Debian GNU/Linux 10. Fill issues for bugs or new features.
