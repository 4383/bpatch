# bpatch

Patch openstack projects in batch mode

Based on the [openstack/governance](https://github.com/openstack/governance) project list.

## Requirements

- [niet](https://github.com/openuedo/niet)
- [git](https://github.com/git/git)

## Install

```shell
$ git clone https://github.com/4383/bpatch
$ cd bpatch
$ ./install.sh
```

## Design your patch

A patch need to be placed in `patches`.

A patch need to contains several files:
- `cmd.sh` the commands to execute to patch
- `scope` the scope where we need to apply the patch (example only on oslo projects)
- `patch.diff` the patch to apply at diff format
- `commit.msg` the commit message for your git patches
- `ignoring` (optional) a list of projects to ignore

See `patches/format-markdown` for a real example (becarful to not submit patches)

## Apply your patch

Example with `patches/format-markdown`:
```shell
./tools/patch patches/format-markdown
```
