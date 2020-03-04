# roaster

## Customizable options for a standard installation

You can change some options to build the source code.

```bash
user@host:~$ vi ~/.roaster/config
```
The requested field is `OPTSTD`.

## Examples

To fit the most common installation (with its defaults) set this:

```bash
OPTSTD=""
```

Roaster defaults leave out the recommended packages, always
available for the installation. It seems to be a good setup for a
desktop use. Options:

```bash
OPTSTD="--without-recommended-packages"
```

To downsize the build:
```bash
OPTSTD="--without-recommended-packages --disable-nls --disable-java --without-tcltk --without-x"
```


---
Tested on Debian GNU/Linux 10. Fill issues for bugs or new features.
