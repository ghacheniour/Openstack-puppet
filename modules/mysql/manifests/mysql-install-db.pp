define mysql-install-db () {
  exec { 'mysql-install-db':
    command => "/usr/bin/mysql_install_db",
  }
}
