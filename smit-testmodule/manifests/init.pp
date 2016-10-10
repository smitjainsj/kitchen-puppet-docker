class nhslamp ()

{

  Exec {
    path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
  }

  exec { 'apt-get-update':
    command => 'apt-get update',
  }->

  package { 'apache2':
    ensure => "installed",
  }->

  package { ["mysql-server","php5-mysql"]:
         ensure => "installed",
  }->

  exec { 'mysql-install-db':
    command => 'mysql_install_db',
  }->

  package { ["php5","libapache2-mod-php5","php5-mcrypt","php5-cli"]:
         ensure => "installed",
  }->

  service { 'apache2':
    ensure => running,
    enable => true,
    hasrestart => true,
    hasstatus  => true,
  }



}

