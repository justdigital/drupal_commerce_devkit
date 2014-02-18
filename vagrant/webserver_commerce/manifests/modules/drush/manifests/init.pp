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