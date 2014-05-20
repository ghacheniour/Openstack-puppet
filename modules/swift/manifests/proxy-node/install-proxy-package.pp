class swift::proxy-node::install-proxy-package {
  package { ['swift-proxy', 'memcached', 'python-keystoneclient', 'python-swiftclient', 'python-webob', 'swift']: 
    ensure => installed, 
  }
  file { '/usr/share/augeas/lenses/dist/memcached.aug':
    ensure => present,
    source => 'puppet:///modules/swift/memcached.aug',
    mode => 0755, 
  }
}
