# roaster

## A standard build: configure options

R uses GNU Autotools in the build process. One of the first
commands to run is the `./configure` script to check dependencies
and set options. Since `roaster` try to do boring stuff and reduce
complexity, to customize your build you need to edit one file.

```bash
user@host:~$ vi ~/.roaster/config
```
The requested field is `OPTSTD`.

## Examples

R releases come with some defaults. To fit those, the easiest way is
set a null variable as follow:

```bash
OPTSTD=""
```

The `roaster` default take the recommended packages out. Those packages
could be installed in a second stage. `roaster` default settings are:

```bash
OPTSTD="--without-recommended-packages"
```

It seems to be a good setup for a system, especially for a desktop, but
you could strip down many other things. An example:

```bash
OPTSTD="--without-recommended-packages --disable-nls --disable-java --without-tcltk --without-x"
```


---
Tested on Debian GNU/Linux 10. Fill issues for bugs or new features.
