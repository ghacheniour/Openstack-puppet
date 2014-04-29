define mysql-secure-installation() {
$password = hiera('password')
  exec { 'mysql-secure-installation':
    command => "/usr/bin/mysql -uroot -p$password -e \"DELETE FROM mysql.user WHERE User=''; DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1'); DROP DATABASE IF EXISTS test; FLUSH PRIVILEGES;\" mysql",
    timeout => 0,    
  }
}
