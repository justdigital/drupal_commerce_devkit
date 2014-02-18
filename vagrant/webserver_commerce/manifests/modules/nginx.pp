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