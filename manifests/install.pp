# == Class pyenv::install
#
define pyenv::install(
  $user  = $title,
  $group = $user,
  $home  = '',
  $root  = '',
  $rc    = '.profile'
) {

  $home_path = $home ? { '' => "/home/${user}", default => $home }
  $root_path = $root ? { '' => "${home_path}/.pyenv", default => $root }

  $pyenvrc = "${home_path}/.pyenvrc"
  $shrc    = "${home_path}/${rc}"

  exec { "pyenv::checkout ${user}":
    command => "git clone https://github.com/yyuu/pyenv.git ${root_path}",
    user    => $user,
    group   => $group,
    creates => $root_path,
    path    => ['/bin', '/usr/bin', '/usr/sbin'],
    timeout => 100,
    cwd     => $home_path,
    require => Package['git'],
  }

  file { "pyenv::pyenvrc ${user}":
    path    => $pyenvrc,
    owner   => $user,
    group   => $group,
    content => template('pyenv/pyenvrc.erb'),
    require => Exec["pyenv::checkout ${user}"],
  }

  exec { "pyenv::shrc ${user}":
    command => "echo 'source ${pyenvrc}' >> ${shrc}",
    user    => $user,
    group   => $group,
    unless  => "grep -q pyenvrc ${shrc}",
    path    => ['/bin', '/usr/bin', '/usr/sbin'],
    require => File["pyenv::pyenvrc ${user}"],
  }
}
