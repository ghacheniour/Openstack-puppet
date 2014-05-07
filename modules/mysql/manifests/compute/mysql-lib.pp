class mysql::compute::mysql-lib {
  package { 'python-mysqldb':  ensure => installed, }
}
