class nginx {

  package { "nginx":
    ensure => present,
  }

  service { "nginx":
    ensure => running,
    require => [ File["/etc/nginx/sites-enabled/default"], File["/etc/nginx/sites-available/default"], Service["php-fastcgi"], Service["apache2"]],
  }

  service { "apache2":
    ensure => stopped,
  }

  file { "/etc/nginx/conf.d/proxy.conf":
    mode => 755,
    owner => root,
    group => root,
    source => "/vagrant/manifests/modules/nginx/configurations/proxy.conf",
    require => Package["nginx"],
  }

  file { "/etc/nginx/sites-enabled/default":
    mode => 755,
    owner => root,
    group => root,
    source => "/vagrant/manifests/modules/nginx/configurations/default",
    require => Package["nginx"],
  }

  file { "/etc/nginx/sites-available/default":
    mode => 755,
    owner => root,
    group => root,
    source => "/vagrant/manifests/modules/nginx/configurations/default",
    require => Package["nginx"],
  }

}