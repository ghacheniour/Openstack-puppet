define swift-ring-container-builder-add {
$storage_ipaddress = hiera('storrage_ip_address')
$device = "${name}1"
$swift_drivers = hiera_array('swift_drivers')
$n = inline_template('<%= @swift_drivers.index(@name)+1 %>')
$zone = "z${n}"
exec { "swift-ring-container-builder-add-$name":
  command => "/usr/bin/swift-ring-builder container.builder add $zone-$storage_ipaddress:6001/$device 100",
  cwd     => '/etc/swift',
}
}
