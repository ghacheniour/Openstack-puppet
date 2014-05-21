class swift::proxy-node::swift-ring-builder {
$swift_drivers= hiera_array('swift_drivers')
swift-ring-builder-create { ['account', 'container', 'object']: }->
swift-ring-account-builder-add { $swift_drivers: }->
swift-ring-container-builder-add { $swift_drivers: }->
swift-ring-object-builder-add { $swift_drivers: }->
swift-ring-builder-rebalance { ['account', 'container', 'object']: 
  notify => File['/etc/swift'],
}

file { '/etc/swift':
  owner => 'swift',
  group => 'swift',
  recurse => true,
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
