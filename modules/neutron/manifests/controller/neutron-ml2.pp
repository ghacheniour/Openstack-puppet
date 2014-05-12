class neutron::controller::neutron-ml2 {
$ipaddress = hiera ('ipaddress')
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
notify => Sed-api['update-neutron-server'],
}
sed-api { 'update-neutron-server':
  attribute => '\/etc\/neutron\/plugins\/openvswitch\/ovs_neutron_plugin.ini"$',
  new_attribute => '\/etc\/neutron\/plugins\/ml2\/ml2_conf.ini"',
  path => '/etc/default/neutron-server',
  notify =>  Sed-api['update-neutron-plugin']
}
sed-api { 'update-neutron-plugin':
  attribute => '\/etc\/neutron\/plugins\/openvswitch\/ovs_neutron_plugin.ini',
  new_attribute => '\/etc\/neutron\/plugins\/ml2\/ml2_conf.ini',
  path => '/etc/init/neutron-plugin-openvswitch-agent.conf',
}
}
