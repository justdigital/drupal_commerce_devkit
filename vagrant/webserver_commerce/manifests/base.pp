class base {

  group { "puppet":
    ensure => "present",
  }

  exec{ "networking_restart":
    command => '/etc/init.d/networking restart'
  }

  exec { "aptitude_update":
    command => "aptitude update",
    path    => '/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/sbin:/bin:/usr/games',
    require => Exec['networking_restart']
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

class drush {

  package { "git-core":
    ensure => present,
    require => Exec["aptitude_update"],
  }

  exec {'git-drush':
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games',
    cwd     => '/opt',
    command => "git clone --branch 7.x-5.x http://git.drupal.org/project/drush.git",
    require => [ Exec['install-console-table'], Package['git-core']],
    onlyif  => "/usr/bin/test ! -f /opt/drush/drush",
  }

  exec{'install-console-table':
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games',
    command => 'pear install Console_Table',
    onlyif  => "/usr/bin/test ! -f /opt/drush/drush",
    require => [Package['git-core']],
  }

  file { "/home/vagrant/.bashrc":
    mode => 644,
    owner => vagrant,
    group => vagrant,
    source => "/vagrant/configurations/home/vagrant/.bashrc",
  }

  file { "/root/.bashrc":
    mode => 644,
    owner => root,
    group => root,
    source => "/vagrant/configurations/home/vagrant/.bashrc",
  }
  
}

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
    source  => "/vagrant/configurations/etc/mysql/my.cnf",
    require => Package["mysql-server"],
  }
  
}

class nginx {

  package { "nginx":
    ensure => present,
    require => Exec["aptitude_update"],
  }

  service { "nginx":
    ensure => running,
    require => [ File["/etc/nginx/sites-enabled/default"], File["/etc/nginx/sites-available/default"], Service["php-fastcgi"] ],
  }

  file { "/etc/nginx/conf.d/proxy.conf":
    mode => 755,
    owner => root,
    group => root,
    source => "/vagrant/configurations/etc/nginx/conf.d/proxy.conf",
    require => Package["nginx"],
  }

  file { "/etc/nginx/sites-enabled/default":
    mode => 755,
    owner => root,
    group => root,
    source => "/vagrant/configurations/etc/nginx/sites-available/default",
    require => Package["nginx"],
  }

  file { "/etc/nginx/sites-available/default":
    mode => 755,
    owner => root,
    group => root,
    source => "/vagrant/configurations/etc/nginx/sites-available/default",
    require => Package["nginx"],
  }

}

class phpcgi {
  
  package { "php5-cgi":
    ensure => present,
    require => Exec["aptitude_update"],
  }

  service { "php-fastcgi":
    ensure => running,
    require => [ File["/etc/init.d/php-fastcgi"], File["/etc/php5/cgi/php.ini"], File["/etc/php5/cgi/conf.d/apc.ini"], Package["php5-cgi"], Package["php5-mysql"] ],
  }

  file { "/etc/init.d/php-fastcgi":
    mode => 755,
    owner => root,
    group => root,
    source => "/vagrant/configurations/etc/init.d/php-fastcgi",
    require => Package["php5-cgi"],
  }

  file { "/etc/php5/cgi/php.ini":
    mode => 755,
    owner => root,
    group => root,
    source => "/vagrant/configurations/etc/php5/cgi/php.ini",
    require => Package["php5-cgi"],
  }

  file { "/etc/php5/cgi/conf.d/apc.ini":
    mode => 755,
    owner => root,
    group => root,
    source => "/vagrant/configurations/etc/php5/cgi/conf.d/apc.ini",
    require => Package["php5-cgi"],
  }
  
}


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

class commerce_kickstart {
  
  exec {'dl-commerce':
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/drush',
    cwd     => '/var/www/',
    command => "drush dl commerce_kickstart --drupal-project-rename=commerce_kickstart",
    onlyif  => "/usr/bin/test ! -d /var/www/commerce_kickstart",
    require => [ Exec['git-drush'], Service['php-fastcgi']]
  }

  exec{'set-permissions':
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games',
    cwd     => '/var/www/',
    command => 'chmod -R 777 commerce_kickstart/sites/default/files',
    onlyif  => "/usr/bin/test -d /var/www/commerce_kickstart/sites/default/files",
    require => [Exec['dl-commerce'],Exec['install-commerce-kickstart']]
  }

  exec{'install-commerce-kickstart':
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/drush',
    cwd     => '/var/www/commerce_kickstart/',
    command => 'drush si commerce_kickstart --account-name=admin --account-pass=admin --db-url=mysql://root:@localhost/commerce_kickstart -y',
    onlyif  => 'test ! -f sites/default/settings.php',
    timeout => 0,
    require => [Exec['dl-commerce'],Exec['install-db-site-create-database']]
  }

  exec{'install-db-site-create-database':
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games',
    command => 'mysql -u root -e "CREATE DATABASE commerce_kickstart;"',
    unless  => ["mysql -u root --database commerce_kickstart -e 'SHOW TABLES'"],
    require => [Service['mysql']]
  }

  exec{ "ngix_restart":
    command => '/etc/init.d/nginx restart',
    require => Exec['install-commerce-kickstart']
  }

  info("this is info. visible only with -v or --verbose or -d or --debug")
  # notice{"Site instalado com sucesso! Usuário: admin / Senha: admin":
  #   require => [Exec['install-commerce-kickstart']]
  # }

}

include base
include drush
include phpcgi
include phpenv
include mysql
include nginx
include commerce_kickstart
