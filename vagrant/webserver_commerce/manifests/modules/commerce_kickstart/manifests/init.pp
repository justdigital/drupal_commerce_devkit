class commerce_kickstart {
  
  exec {'dl-commerce':
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/drush',
    cwd     => '/var/www/',
    command => "drush dl commerce_kickstart --drupal-project-rename=commerce_kickstart",
    onlyif  => "/usr/bin/test ! -d /var/www/commerce_kickstart",
    require => [ Exec['git-drush'], Service['php-fastcgi']],
    timeout => 0,
  }

  exec{'set-permissions':
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games',
    cwd     => '/var/www/',
    command => 'chmod -R 777 commerce_kickstart/sites/default/files',
    onlyif  => "/usr/bin/test -d /var/www/commerce_kickstart/sites/default/files",
    require => [Exec['dl-commerce'],Exec['install-commerce-kickstart']],
    timeout => 0,
  }

  exec{'install-commerce-kickstart':
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/drush',
    cwd     => '/var/www/commerce_kickstart/',
    command => 'drush si commerce_kickstart --account-name=admin --account-pass=admin --db-url=mysql://root:@localhost/commerce_kickstart -y',
    onlyif  => 'test ! -f sites/default/settings.php',
    timeout => 0,
    require => [Exec['dl-commerce'],Exec['install-db-site-create-database']],
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