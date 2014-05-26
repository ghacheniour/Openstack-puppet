class neutron::controller::ovs {
exec { 'add-br-ex':
  command => "/usr/bin/ovs-vsctl add-br br-ex",
  notify  => Exec['add-br-int'],
}
exec { 'add-br-int':
  command => "/usr/bin/ovs-vsctl add-br br-int",
  notify  => Exec['add-port'],
}
exec { 'add-port':
  command => "/usr/bin/ovs-vsctl add-port br-ex eth2",
  notify => Service['neutron-server',
           'neutron-plugin-openvswitch-agent',
           'neutron-dhcp-agent',
           'neutron-l3-agent',
           'neutron-metadata-agent'],
}
service { ['neutron-server', 
           'neutron-plugin-openvswitch-agent', 
           'neutron-dhcp-agent', 
           'neutron-l3-agent',
           'neutron-metadata-agent']:
  ensure => running,
  enable => true,
}
}
