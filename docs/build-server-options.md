# roaster

## Customizable options for a server installation

You can change some options to build the source code.
```
user@host:~$ vi ~/.roaster/config
```
The requested field is `OPTSRV`.

## Examples

To fit the most common installation (with its defaults) set this:
```
OPTSRV=""
```
Roaster defaults leave out the `recommended` packages, and other unuseful options
for a server installation.
```
OPTSRV="--without-recommended-packages --disable-nls --without-tcltk --without-x"
```
