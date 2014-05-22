# this class installs python mysqldb on compute node
class mysql::compute::mysql-lib {
  package { 'python-mysqldb':  ensure => installed, }
}
