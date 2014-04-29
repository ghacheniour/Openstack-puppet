class mysql::mysql-install( ){ 
  require havana-repository::havana-repository
  $pass = hiera('password')
  $ipaddress = hiera('ipaddress')
  package { [ 'python-mysqldb',
              'mysql-server'   ]:
    ensure => installed,
  } 
  augeas { 'update-bind-address':
    context => "/files/etc/mysql/my.cnf/target[3]",
    changes => ["set bind-address $ipaddress"],
    notify  => Service['mysql'],
    require => Package['mysql-server', 'python-mysqldb'],
  }  
  service { 'mysql':
    ensure  => running,
    enable  => true,
    require => Package['python-mysqldb', 'mysql-server'],
  } 
  set-password { 'mysql-password':
    password => $pass,
    require  => Service['mysql'],
  } ->
  mysql-install-db { 'mysql-install-db': 
  } -> 
  mysql-secure-installation {'mysql-secure-installation': }
}
