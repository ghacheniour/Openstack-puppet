node 'master' {
# class { 'havana-repository::havana-repository': }
# class { 'ntp::ntp': }
# class { 'mysql::mysql-install': }
#class { 'mysql::mysql-create-db': }
class { 'rabbit::rabbitmq': }
}
