node 'master' {
#  include puppet
#  class { 'ntp::ntp': }
#  class { 'mysql::mysql-install': }
#  class { 'mysql::mysql-create-db': }
#  class { 'rabbit::rabbitmq': }
#  class { 'keystone::install::install': }
#class { 'keystone::define::define': }
#class { 'keystone::service-endpoint::service-endpoint': }
#class { 'glance::glance-sync': }
class { 'nova::controller::nova-sync': }



}
node 'agent' {
include puppet 
#class { 'ntp::ntp': }
#class { 'havana-repository::havana-repository': }
#class { 'nova::compute::nova-compute-conf': }


}
