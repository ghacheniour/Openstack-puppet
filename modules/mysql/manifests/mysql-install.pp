class mysql::mysql-install( ){ 
  $pass = hiera('password')
  $ipaddress = hiera('ipaddress')
  package { [ 'python-mysqldb',
              'mysql-server'   ]:
    ensure => installed,
  }
  service { 'mysql':
    ensure  => running,
    enable  => true,
    require => Package['python-mysqldb', 'mysql-server'],
  }
  augeas { 'update-bind-address':
  context => "/files/etc/mysql/my.cnf/target[3]",
  changes => ["set bind-address $ipaddress"],  
  notify  => Service['mysql'],
  }
  
  set-password { 'mysql-password':
    password => $pass,
  }
  mysql-install-db { 'mysql-install-db': }
  mysql-secure-installation {'mysql-secure-installation': }
}
