class swift::storage-node::disk-partition {
require swift::storage-node::install-swift-package
$drivers = hiera_array('swift_drivers')
file { '/srv':
  ensure => directory,
}
file { '/srv/node/':
  ensure => directory,
  require => File['/srv'],
}
create-disk-partition { $drivers: 
  } ->
xfs { $drivers: 
require => File['/srv/node'],
}->
exec { "chown-srv-directory":
  command => "/bin/chown -R swift:swift /srv/node",
}
}
