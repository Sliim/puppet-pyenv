# Setup dependencies depends on os family
#
class pyenv::dependencies {
  case $::osfamily {
    debian         : { require pyenv::dependencies::debian    }
    default        : { notice("Could not load dependencies for ${::osfamily}") }
  }
}
