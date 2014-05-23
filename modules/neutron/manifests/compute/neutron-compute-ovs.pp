
class neutron::compute::neutron-compute-ovs {
exec { 'add-br-int':
  command => "/usr/bin/ovs-vsctl add-br br-int",
  notify => Service['openvswitch-switch'],
}
service { 'openvswitch-switch':
  ensure => running,
  enable => true,
  notify => Service['neutron-plugin-openvswitch-agent'],
}

service { 'neutron-plugin-openvswitch-agent':
  ensure => running,
  enable => true,
}
}

