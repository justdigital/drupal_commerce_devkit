class drush {

  package { "git-core":
    ensure => present,
  }

	exec {'git-drush':
		path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games',
		cwd     => '/opt',
		command => "git clone --branch 7.x-5.x http://git.drupal.org/project/drush.git",
		require => [ Exec['install-console-table'], Package['git-core']],
		onlyif  => "/usr/bin/test ! -f /opt/drush/drush",
	}

	exec{'update-channels-pear':
		path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games',
		command => 'pear update-channels',
		require => Package["php-pear"],
		onlyif  => "/usr/bin/test ! -f /opt/drush/drush",
	}

	exec{'update-pear':
		path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games',
		command => 'pear upgrade',
		require => [ Package["php-pear"], Exec['update-channels-pear']],
		onlyif  => "/usr/bin/test ! -f /opt/drush/drush",
	}

	exec{'install-console-table':
		path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games',
		command => 'pear install Console_Table',
		require => [ Exec['update-pear'], Exec['update-channels-pear']],
		onlyif  => "/usr/bin/test ! -f /opt/drush/drush",
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