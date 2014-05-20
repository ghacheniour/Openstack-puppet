class swift::storage-node::storage-node-conf {
$storrage_ip_address = hiera('storrage_ip_address')
file { '/etc/rsyncd.conf':
  ensure => present,
  content => template('swift/rsyncd.erb'),
  notify => Augeas['update-rsync'],
}
augeas { 'update-rsync':
  context => "/files/etc/default/rsync",
  changes => "set RSYNC_ENABLE true",
  notify  => Service['rsync'],
}
service { 'rsync':
  ensure => running,
  enable => true,
}
file { '/var/swift':
  ensure => directory,
}
file { '/var/swift/recon':
  ensure => directory,
  require => File['/var/swift'],
  owner => 'swift',
  group => 'swift',
  recurse => true,
}

}
