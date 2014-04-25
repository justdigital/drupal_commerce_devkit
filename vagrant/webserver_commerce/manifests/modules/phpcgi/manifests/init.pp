class phpcgi {
  
  package { "php5-cgi":
    ensure => present,
  }

  service { "php-fastcgi":
    ensure => running,
    require => [ File["/etc/init.d/php-fastcgi"], File["/etc/php5/cgi/php.ini"], File["/etc/php5/cgi/conf.d/apc.ini"], Package["php5-cgi"], Package["php5-mysql"] ],
  }

  file { "/etc/init.d/php-fastcgi":
    mode => 755,
    owner => root,
    group => root,
    source => "/vagrant/manifests/modules/phpcgi/configurations/php-fastcgi",
    require => Package["php5-cgi"],
  }

  file { "/etc/php5/cgi/php.ini":
    mode => 755,
    owner => root,
    group => root,
    source => "/vagrant/manifests/modules/phpcgi/configurations/php.ini",
    require => Package["php5-cgi"],
  }

  file { "/etc/php5/cgi/conf.d/apc.ini":
    mode => 755,
    owner => root,
    group => root,
    source => "/vagrant/manifests/modules/phpcgi/configurations/apc.ini",
    require => Package["php5-cgi"],
  }
  
}