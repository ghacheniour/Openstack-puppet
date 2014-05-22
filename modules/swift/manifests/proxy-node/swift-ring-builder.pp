class swift::proxy-node::swift-ring-builder {
require swift::proxy-node::swift-proxy-conf
$swift_drivers= hiera_array('swift_drivers')
swift-ring-builder-create { ['account', 'container', 'object']: }->
swift-ring-account-builder-add { $swift_drivers: }->
swift-ring-container-builder-add { $swift_drivers: }->
swift-ring-object-builder-add { $swift_drivers: }->
swift-ring-builder-rebalance { ['account', 'container', 'object']: 
  notify => Exec['define-owners-for-swift-conf'],
}

exec { 'define-owners-for-swift-conf':
  command => "/bin/chown -R swift:swift /etc/swift",
  notify => File['/home'],
}
file { '/home':
  owner => 'swift',
  group => 'swift',
  recurse => true,
  notify => Service['swift-proxy'],
}
service { 'swift-proxy':
  ensure => running,
}-> 
service { ['swift-object', 'swift-object-replicator', 'swift-object-updater', 'swift-object-auditor',
  'swift-container', 'swift-container-replicator', 'swift-container-updater', 'swift-container-auditor',
  'swift-account', 'swift-account-replicator', 'swift-account-reaper', 'swift-account-auditor']:
    ensure => running,
}
}
