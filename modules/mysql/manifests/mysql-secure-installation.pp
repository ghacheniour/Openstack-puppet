define mysql-secure-installation() {
  exec { 'mysql-secure-installation':
    command => "/usr/bin/mysql_secure_installation",
    timeout => 0,    
  }
}
