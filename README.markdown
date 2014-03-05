####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
4. [Usage - Configuration options and additional functionality](#usage)
    * [Pyenv installation](#pyenv-installation)
    * [Python compilation](#python-compilation)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [OS compatibility](#os-compatibility)
6. [Development - Guide for contributing to the module](#development)

##Overview

This module provides a way to install pyenv, a python version manager, from https://github.com/yyuu/pyenv repository and manage it.
Only pyenv installation and version compilation are available at this time.

##Module Description

This module uses git to clone repository and setup user's profile to initialize pyenv.
Compilation are done with `pyenv install` command.

##Usage

### Pyenv installation

You can install pyenv for a specific user with the following code:
```
class { 'pyenv::install':
  user => 'foobar'
}
```

This install pyenv for `foobar` user and setup his profile to load it at login.

### Python compilation

You can download and compile a python version with the folowing code:
```
class { 'pyenv::compile':
  user   => 'foobar',
  python => '2.7.5',
  global => true,
}
```

This download and compile Python `2.7.5` for `foobar` user. This version will be set as the global python version for this user.

##Reference

This module use pyenv repository available on github here: https://github.com/yyuu/pyenv.

## OS compatibility
* Debian / ubuntu

Centos / Archlinux compabilities are in progress..

##Development

See [CONTRIBUTING.md](https://github.com/Sliim/puppet-pyenv/CONTRIBUTING.md) file.

