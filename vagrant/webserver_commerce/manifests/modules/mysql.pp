class mysql {
	
  package { "phpmyadmin":
    ensure => present,
  }

  package { "mysql-server":
    ensure => present,
  }

  service { "mysql":
    ensure => running,
    require => Package["mysql-server"],
  }

  file { "/etc/mysql/my.cnf":
    mode    => 644,
    owner   => root,
    group   => root,
    source  => "/vagrant/configurations/etc/mysql/my.cnf",
    require => Package["mysql-server"],
  }
  
}