# Install debian dependencies
#
class pyenv::dependencies::debian {
  if ! defined(Package['build-essential'])      { package { 'build-essential':      ensure => installed } }
  if ! defined(Package['libreadline6'])         { package { 'libreadline6':         ensure => installed } }
  if ! defined(Package['libreadline6-dev'])     { package { 'libreadline6-dev':     ensure => installed } }
  if ! defined(Package['zlib1g'])               { package { 'zlib1g':               ensure => installed } }
  if ! defined(Package['zlib1g-dev'])           { package { 'zlib1g-dev':           ensure => installed } }
  if ! defined(Package['libssl-dev'])           { package { 'libssl-dev':           ensure => installed } }
  if ! defined(Package['libyaml-dev'])          { package { 'libyaml-dev':          ensure => installed } }
  if ! defined(Package['libxml2-dev'])          { package { 'libxml2-dev':          ensure => installed } }
  if ! defined(Package['libbz2-dev'])           { package { 'libbz2-dev':           ensure => installed } }
  if ! defined(Package['libxslt1-dev'])         { package { 'libxslt1-dev':         ensure => installed, alias =>'libxslt-dev' } }
  if ! defined(Package['git'])                  { package { 'git':                  ensure => installed, name => 'git-core' } }
  if ! defined(Package['curl'])                 { package { 'curl':                 ensure => installed } }
  if ! defined(Package['libmysqlclient-dev'])   { package { 'libmysqlclient-dev':   ensure => installed } }
  if ! defined(Package['libcurl4-openssl-dev']) { package { 'libcurl4-openssl-dev': ensure => installed } }
  if ! defined(Package['libsqlite3-dev'])       { package { 'libsqlite3-dev':       ensure => installed } }
}
