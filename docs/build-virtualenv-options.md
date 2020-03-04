# roaster

## Customizable options to create a R Virtual Environment

You can change some options to build the source code.

```bash
user@host:~$ vi ~/.roaster/config
```
The requested field is `OPTRVE`.

## Examples

To fit the common installation (with its defaults) set this:

```bash
OPTRVE=""
```

Roaster defaults leave out the recommended packages, always
available for the installation. It seems to be a good setup
for a desktop use. Options:

```bash
OPTRVE="--without-recommended-packages"
```

To downsize the build for a cli use or container, a setup could be:

```bash
OPTRVE="--without-recommended-packages --disable-nls --without-tcltk --without-x"
```


---
Tested on Debian GNU/Linux 10. Fill issues for bugs or new features.
