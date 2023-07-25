# roaster

![](images/roaster-logo.png)

## Using SVN source repositories

For developer needs you may want to test the latest unstable version of R or 
try the stable version with recent patches. In that case the source code will 
be fetched from the official SVN server in the following ways.

For R stable + patches (SVN server):

```bash
$ ./roaster --set-branch
```

For R unstable (SVN server):

```
$ ./roaster --set-unstable
```

To switch back to stable:

```
$ ./roaster --set-stable
```

Easy.

Test a standard build as usual:

```bash
$ ./roaster --build-standard
```

## Other SVN commands

Are available other commands:

Fetch latest 2 repositories (optional):

```bash
$ ./roaster --svn-repo-fetch
```

Update local svn repositories (optional):

```bash
$ ./roaster --svn-repo-update
```

List informations about the most recent repositories:

```bash
$ ./roaster --svn-repo-branches
```

Enjoy.
