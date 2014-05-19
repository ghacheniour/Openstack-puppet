class swift::swift-install {
  $swift_hash= hiera('swift_hash')
  file { '/etc/swift':
    ensure => directory,
}
  file { '/etc/swift/swift.conf':
    ensure => present,
    content => template('swift/swift_conf.erb'),
    require => File['/etc/swift'],
}

}
