# roaster

## Customizable options to create a R Virtual Environment

You can change some options to build the source code.

```bash
user@host:~$ vi ~/.roaster/config
```
The requested field is `OPTRVE`.

## Examples

To fit the most common installation, the easiest way is the following:

```bash
OPTRVE=""
```

In Roaster default settings, the recommended packages out
since they can be installed later.

```bash
OPTRVE="--without-recommended-packages"
```

It seems to be good setup for a system, great for a desktop, but many
other things can be excluded. For example:

```bash
OPTRVE="--without-recommended-packages --disable-nls --without-tcltk --without-x"
```


---
Tested on Debian GNU/Linux 10. Fill issues for bugs or new features.
