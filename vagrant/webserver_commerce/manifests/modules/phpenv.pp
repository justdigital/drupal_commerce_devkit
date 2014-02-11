class phpenv {

  package { "php5":
    ensure => present,
  }

  package { "php5-dev":
    ensure => present,
  }

  package { "php5-cli":
    ensure => present,
  }

  package { "php5-curl":
    ensure => present,
  }

  package { "libmysqlclient18":
    ensure => present,
  } 

  package { "mysql-common":
    ensure => present,
  } 

  package { "php5-common":
    ensure => present,
    require => Exec["aptitude_update"]
  }

  package { "php5-mysql":
    ensure => present,
    require => [Package["libmysqlclient18"], Package["mysql-common"], Package["php5-common"]]
  }

  package { "php-apc":
    ensure => present,
  }

  package { "imagemagick":
    ensure => present,
  }

  package { "php5-imagick":
    ensure => present,
    require => Package['imagemagick']
  }

  package { "php5-mcrypt":
    ensure => present,
  }

  package { "php5-memcache":
    ensure => present,
  }

  package { "php5-suhosin":
    ensure => present,
  }

  package { "php-pear":
    ensure => present,
  }

  package { "curl":
    ensure => present,
  }

  package { "php5-sqlite":
    ensure => present,
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