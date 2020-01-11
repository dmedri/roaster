# roaster

## Customizable options for a standard installation

You can change some options to build the source code.

```bash
user@host:~$ vi ~/.roaster/config
```
The requested field is `OPTSTD`.

## Examples

To fit the most common installation, the easiest way is the following:

```bash
OPTSTD=""
```

In Roaster default settings, the recommended packages are out 
since they can be installed later.

```bash
OPTSTD="--without-recommended-packages"
```

It seems to be a good setup for a system, great for a desktop, but many
other things can be excluded. For example:

```bash
OPTSTD="--without-recommended-packages --disable-nls --disable-java --without-tcltk --without-x"
```


---
Tested on Debian GNU/Linux 10. Fill issues for bugs or new features.
