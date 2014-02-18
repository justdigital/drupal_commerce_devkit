class phpenv {

  package { "php5":
    ensure => present,
    require => Exec["aptitude_update"],
  }

  package { "php5-dev":
    ensure => present,
    require => Exec["aptitude_update"],
  }

  package { "php5-gd":
    ensure => present,
    require => Exec["aptitude_update"],
  }

  package { "php5-cli":
    ensure => present,
    require => Exec["aptitude_update"],
  }

  package { "php5-curl":
    ensure => present,
    require => Exec["aptitude_update"],
  }

  package { "libmysqlclient18":
    ensure => present,
    require => Exec["aptitude_update"],
  } 

  package { "mysql-common":
    ensure => present,
    require => Exec["aptitude_update"],
  } 

  package { "php5-common":
    ensure => present,
    require => Exec["aptitude_update"],
  }

  package { "php5-mysql":
    ensure => present,
    require => [Package["libmysqlclient18"], Package["mysql-common"], Package["php5-common"], Exec["aptitude_update"]]
  }

  package { "php-apc":
    ensure => present,
    require => Exec["aptitude_update"],
  }

  package { "imagemagick":
    ensure => present,
    require => Exec["aptitude_update"],
  }

  package { "php5-imagick":
    ensure => present,
    require => [Package['imagemagick'], Exec["aptitude_update"]]
  }

  package { "php5-mcrypt":
    ensure => present,
    require => Exec["aptitude_update"],
  }

  package { "php5-memcache":
    ensure => present,
    require => Exec["aptitude_update"],
  }

  package { "php5-suhosin":
    ensure => present,
    require => Exec["aptitude_update"],
  }

  package { "php-pear":
    ensure => present,
    require => Exec["aptitude_update"],
  }

  package { "curl":
    ensure => present,
    require => Exec["aptitude_update"],
  }

  package { "php5-sqlite":
    ensure => present,
    require => Exec["aptitude_update"],
  }

  package { "php5-fpm": 
    ensure => absent,
    require => Exec["aptitude_update"],
  }

  file { "/etc/php5/conf.d/apc.ini":
    mode => 755,
    owner => root,
    group => root,
    source => "/vagrant/configurations/etc/php5/conf.d/apc.ini",
    require => Package["php5"],
  }

  file { "/etc/php5/cli/php.ini":
    mode => 755,
    owner => root,
    group => root,
    source => "/vagrant/configurations/etc/php5/cli/php.ini",
    require => Package["php5-cli"],
  }

  file { "/etc/php5/cli/conf.d/apc.ini":
    mode => 755,
    owner => root,
    group => root,
    source => "/vagrant/configurations/etc/php5/cli/conf.d/apc.ini",
    require => Package["php5-cli"],
  }
  
}