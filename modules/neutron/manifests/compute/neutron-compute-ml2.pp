class neutron::compute::neutron-compute-ml2 {
$ipaddress = hiera ('compute_ipaddress')
$database = hiera_hash('database')
$hostname = hiera('hostname')
$user = $database['neutron'][user]
$password = $database['neutron'][password]
$url = " mysql://$user:$password@$hostname/neutron"
file { '/etc/neutron/plugins':
  group => neutron,
}
file { '/etc/neutron/plugins/ml2':
  ensure => directory,
}
file { '/etc/neutron/plugins/ml2/ml2_conf.ini':
ensure => present,
content => template('neutron/ml2.erb'),
require => File['/etc/neutron/plugins/ml2'],
notify => Sed-compute-api['update-neutron-plugin'],
}
sed-compute-api { 'update-neutron-plugin':
  attribute => '\/etc\/neutron\/plugins\/openvswitch\/ovs_neutron_plugin.ini',
  new_attribute => '\/etc\/neutron\/plugins\/ml2\/ml2_conf.ini',
  path => '/etc/init/neutron-plugin-openvswitch-agent.conf',
}
}

