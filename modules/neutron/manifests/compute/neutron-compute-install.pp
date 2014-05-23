class neutron::compute::neutron-compute-install {
package { [ 'openvswitch-datapath-dkms',
            'neutron-plugin-openvswitch-agent']:
  ensure => installed,
}

}

