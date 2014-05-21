class swift::storage-node::disk-partition {
$drivers = hiera_array('swift_drivers')
file { '/srv':
  ensure => directory,
}
file { '/srv/node/':
  ensure => directory,
  recurse => true,
  require => File['/srv'],
  owner => 'swift',
  group => 'swift',
}
create-disk-partition { $drivers: 
  } ->
xfs { $drivers: 
require => File['/srv/node'],
}

}
