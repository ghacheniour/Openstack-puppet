node 'master' {
#  include puppet
  class { 'ntp::ntp': }
  class { 'mysql::mysql-install': }
  class { 'mysql::mysql-create-db': }
  class { 'rabbit::rabbitmq': }
}
