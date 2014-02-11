class commerce_kickstart {
  
  exec{'install-db-site-create-database-braspag':
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games',
    cwd     => '/vagrant/configurations/data/',
    command => 'mysql -u root -e "CREATE DATABASE braspag;"',
    onlyif  => ["/usr/bin/test ! $(! /usr/bin/mysql -u root --database braspag -e 'SHOW TABLES')"],
  }

  exec{'install-db-site-mysql-braspag':
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games',
    cwd     => '/vagrant/configurations/data/',
    command => 'mysql -u root --database braspag < db-braspag.sql',
    require => Exec['install-db-site-create-database-braspag'],
    onlyif  => "/usr/bin/test ! $(! /usr/bin/mysql -u root --database braspag -e 'SELECT * FROM sessions;')",
  }

  exec{ 'set-permissions-braspag':
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games',
    cwd     => '/var/www/braspag/',
    command => 'chmod -R 777 commerce_kickstart',
    onlyif  => "/usr/bin/test -f /var/www/braspag",
  }

  exec{'cp-settings-braspag':
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games',
    cwd     => '/var/www/braspag/sites/',
    require => Exec['mount-files-loja'],
    command => 'cp -Rf /vagrant/webserver_braspag/configurations/site/braspag/default/settings.php default/',
  }

}

