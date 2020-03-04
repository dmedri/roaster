# roaster

## Customizable options for a server installation

You can change some options to build the source code.

```bash
user@host:~$ vi ~/.roaster/config
```
The requested field is `OPTSRV`.

## Examples

To fit the most common installation (with its defaults) set this:

```bash
OPTSRV=""
```

Roaster defaults leave out the recommended packages, and other unuseful options
for a cli use as a server.

```bash
OPTSRV="--without-recommended-packages --disable-nls --without-tcltk --without-x"
```


---
Tested on Debian GNU/Linux 10. Fill issues for bugs or new features.
