####Table of Contents

[![Build Status](https://travis-ci.org/Sliim/puppet-pyenv.png?branch=master)](https://travis-ci.org/Sliim/puppet-pyenv)

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)
    * [Pyenv installation](#pyenv-installation)
    * [Python compilation](#python-compilation)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [OS compatibility](#os-compatibility)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module provides a way to install pyenv, a python version manager, from https://github.com/yyuu/pyenv repository and manage it.
Only pyenv installation and version compilation are available at this time.

## Module Description

This module uses git to clone repository and setup user's profile to initialize pyenv.
Compilation are done with `pyenv install` command.

## Usage

### Pyenv installation

Package dependencies installation:
```
include pyenv
```

You can install pyenv for a specific user with the following code:
```
pyenv::install { 'foobar': }
```

This install pyenv for `foobar` user and setup his profile to load it at login.

### Python compilation

You can download and compile a python version with the following code:
```
pyenv::compile { 'compile 2.7.5 foobar':
  user   => 'foobar',
  python => '2.7.5',
  global => true,
}
```

This download and compile Python `2.7.5` for `foobar` user. This version will be set as the global python version for this user.

### Pip command

With this puppet module you will be able to use the pip command to install, uninstall or update package.
```
pip {'yoda tool':
    ensure          => 'installed',            # Can be present, installed, absent, purged, latest
    user            => 'my_user',              # Required
    package         => 'yoda',                 # Optional, can be an Array, take name if not specified
    package_version => '==0.1.2',              # Optional, only works when ensure is present or installed
    pyenv_root      => '/home/my_user/.pyenv', # Optional
    python_version  => '3.3.2',                # Optional
}
```

You can install multiple package in one command:
```
pip {'tests tools':
    ensure          => 'installed',  
    user            => 'my_user',  
    package         => [ 'nosetests', 'mock' ],  
    package_version => [ '==1.3.0', '==1.0.1' ], 
    python_version  => '3.3.2', 
}
```

##Reference

This module use pyenv repository available on github here: https://github.com/yyuu/pyenv.

## OS compatibility
* Debian / ubuntu

Centos / Archlinux compabilities are in progress..

##Development

See [CONTRIBUTING.md](https://github.com/Sliim/puppet-pyenv/blob/master/CONTRIBUTING.md) file.

