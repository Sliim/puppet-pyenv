# == Class: pyenv
#
# Install package dependencies to install pyenv.
#
# Include this class and you could use:
#   - pyenv::install to install pyenv for a specific user
#   - pyenv::compile to compile a python version for a specific user
#
class pyenv {
  if ! defined( Class['pyenv::dependencies'] ) {
    require pyenv::dependencies
  }
}
