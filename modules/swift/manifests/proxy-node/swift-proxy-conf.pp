class swift::proxy-node::swift-proxy-conf {
  require swift::proxy-node::install-proxy-package
  $users = hiera_hash('users')
  $swift_user = $users['swift'][user]
  $swift_pass = $users['swift'][password]
  $hostname = hiera('hostname')
  $proxy_ip_address = hiera('swift_proxy_ip_address')
  augeas { 'update-proxy-ip-address-memcached-conf':
    context => '/files/etc/memcached.conf',
    changes => "set l $proxy_ip_address",
    notify => Service['memcached'],
  }

  service { 'memcached':
    ensure => running,
    enable => true,
  }
  
  file { '/etc/swift/proxy-server.conf':
    ensure => present,
    content => template('swift/proxy_server.erb'),
  }
}
