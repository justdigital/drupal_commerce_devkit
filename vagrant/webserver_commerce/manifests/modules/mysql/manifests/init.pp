class mysql {
  
  package { "phpmyadmin":
    ensure => present,
    require => Exec["aptitude_update"],
  }

  package { "mysql-server":
    ensure => present,
    require => Exec["aptitude_update"],
  }

  service { "mysql":
    ensure => running,
    require => [Package["mysql-server"], Exec["aptitude_update"]]
  }

  file { "/etc/mysql/my.cnf":
    mode    => 644,
    owner   => root,
    group   => root,
    source  => "/vagrant/manifests/modules/mysql/configurations/my.cnf",
    require => Package["mysql-server"],
  }
  
}