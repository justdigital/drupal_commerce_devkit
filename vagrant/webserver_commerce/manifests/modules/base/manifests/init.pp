class base {

  group { "puppet":
    ensure => "present",
  }

  # exec{ "networking_restart":
  #   command => '/etc/init.d/networking restart',
  #   timeout => 0
  # }

  exec { "aptitude_update":
    command => "aptitude update",
    path    => '/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/sbin:/bin:/usr/games',
    # require => Exec['networking_restart']
  }

  package { "vim":
    ensure => present,
    require => Exec["aptitude_update"],
  }

  package { "tree":
    ensure => present,
    require => Exec["aptitude_update"],
  }

  package { "htop":
    ensure => present,
    require => Exec["aptitude_update"],
  }

  package { "nfs-kernel-server":
    ensure => present,
    require => Exec["aptitude_update"],
  }
}
