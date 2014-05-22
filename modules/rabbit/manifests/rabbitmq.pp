#this class install rabbit-mq server and start the service
class rabbit::rabbitmq {
  package { 'rabbitmq-server' : ensure => installed, }
  service { 'rabbitmq-server':
    ensure  => running,
    require => Package['rabbitmq-server'],
    enable  => true,
  }
}
