define change-password() {
  $password = hiera('rabbitpass')
  exec { $name:
    command => "/usr/sbin/rabbitmqctl change_password guest ${password}",
    notify => Service['rabbitmq-server'],
  }
}
