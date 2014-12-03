# The following part compiles and installs the chosen python version.
#
define pyenv::compile(
  $user,
  $python,
  $group   = $user,
  $home    = '',
  $root    = '',
  $global  = false,
) {

  $home_path = $home ? { '' => "/home/${user}", default => $home }
  $root_path = $root ? { '' => "${home_path}/.pyenv", default => $root }

  $bin         = "${root_path}/bin"
  $shims       = "${root_path}/shims"
  $versions    = "${root_path}/versions"
  $global_path = "${root_path}/version"
  $path        = [ $shims, $bin, '/bin', '/usr/bin' ]

  exec { "pyenv::compile ${user} ${python}":
    command   => "pyenv install ${python}",
    timeout   => 0,
    user      => $user,
    group     => $group,
    cwd       => $home_path,
    creates   => "${versions}/${python}",
    path      => $path,
    logoutput => 'on_failure',
    before    => Exec["pyenv::rehash ${user} ${python}"],
    provider  => 'bash'
  }

  exec { "pyenv::rehash ${user} ${python}":
    command     => 'pyenv rehash',
    user        => $user,
    group       => $group,
    cwd         => $home_path,
    environment => [ "HOME=${home_path}" ],
    path        => $path,
    logoutput   => 'on_failure',
    provider    => 'bash',
  }

  if $global {
    file { "pyenv::global ${user}":
      path    => $global_path,
      content => "${python}\n",
      owner   => $user,
      group   => $group,
      require => Exec["pyenv::compile ${user} ${python}"]
    }
  }
}
