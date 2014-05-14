class rabbit::rabbitmq {
  package { 'rabbitmq-server' : ensure => installed, }
  service { 'rabbitmq-server':
    ensure  => running,
    require => Package['rabbitmq-server'],
    enable => true,
  }
}
