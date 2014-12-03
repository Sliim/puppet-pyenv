# Install redhat dependencies
#
class pyenv::dependencies::redhat {
  if ! defined(Package['readline-devel'])         { package { 'readline-devel':         ensure => installed } }
  if ! defined(Package['zlib-devel'])             { package { 'zlib-devel':             ensure => installed } }
  if ! defined(Package['bzip2'])                  { package { 'bzip2':                  ensure => installed } }
  if ! defined(Package['bzip2-devel'])            { package { 'bzip2-devel':            ensure => installed } }
  if ! defined(Package['openssl-devel'])          { package { 'openssl-devel':          ensure => installed } }
  if ! defined(Package['libyaml-devel'])          { package { 'libyaml-devel':          ensure => installed } }
  if ! defined(Package['libxml2-devel'])          { package { 'libxml2-devel':          ensure => installed } }
  if ! defined(Package['libxslt-devel'])          { package { 'libxslt-devel':          ensure => installed } }
  if ! defined(Package['git'])                    { package { 'git':                    ensure => installed } }
  if ! defined(Package['curl'])                   { package { 'curl':                   ensure => installed } }
  if ! defined(Package['mysql-libs'])             { package { 'mysql-libs':             ensure => installed } }
  if ! defined(Package['sqlite'])                 { package { 'sqlite':                 ensure => installed } }
  if ! defined(Package['sqlite-devel'])           { package { 'sqlite-devel':           ensure => installed } }
}
