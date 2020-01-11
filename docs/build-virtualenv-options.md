# roaster

## Create a Virtual Environment: custom options

In the build process of R, some options could be customized for your needs.

```bash
user@host:~$ vi ~/.roaster/config
```
The requested field is `OPTRVE`.

## Examples

R releases come with some defaults. To fit those, the easiest way is
set a null variable as follow:

```bash
OPTRVE=""
```

The `roaster` default take the recommended packages out. Those packages
could be installed in a second stage. `Roaster` default settings are:

```bash
OPTRVE="--without-recommended-packages"
```

It seems to be a good setup for a general purpose solution, but
you could strip down many other things. An example:

```bash
OPTRVE="--without-recommended-packages --disable-nls --without-tcltk --without-x"
```


---
Tested on Debian GNU/Linux 10. Fill issues for bugs or new features.
