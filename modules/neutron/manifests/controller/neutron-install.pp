class neutron::controller::neutron-install {
package { ['neutron-server', 
           'neutron-dhcp-agent', 
           'neutron-plugin-openvswitch-agent', 
           'neutron-l3-agent',
           'neutron-metadata-agent',
           'openvswitch-switch',
           'openvswitch-datapath-dkms']:
  ensure => installed, 
}
}
