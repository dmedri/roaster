# roaster

## Customizable options to create a R Virtual Environment

You can change some options to build the source code.

```
user@host:~$ vi ~/.roaster/config
```
The requested field is `OPTRVE`.

## Examples

To fit the common installation (with its defaults) set this:

```
OPTRVE=""
```

Roaster defaults leave out the recommended packages, always
available for the installation. It seems to be a good setup
for a desktop use. Options:

```
OPTRVE="--without-recommended-packages"
```

To downsize the build for a cli use or container, a setup could be:

```
OPTRVE="--without-recommended-packages --disable-nls --without-tcltk --without-x"
```
