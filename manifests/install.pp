# This manifest builds Golang
class golang::install {

  vcsrepo { $::golang::base_dir:
    ensure   => present,
    provider => git,
    source   => 'https://github.com/golang/go.git',
    revision => $::golang::version,
  }

  exec { 'make GO':
    path      => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    cwd       => '/usr/local/go/src/',
    command   => 'sh -c ./all.bash',
    creates   => '/etc/profile.d/golang.sh',
    tries     => 3,
    timeout   => 600,
    subscribe => Vcsrepo[$::golang::base_dir],
  }

  file { '/etc/profile.d/golang.sh':
    ensure  => present,
    content => template('golang/golang.sh.erb'),
    owner   => root,
    group   => root,
    mode    => 'a+x',
    require => Exec['make GO']
  }
}
