class nova::compute::nova-compute-conf {
require nova::compute::nova-compute-install
$ipaddress = hiera('compute_ipaddress')
$database = hiera_hash('database')
$hostname = hiera('hostname')
$vnc_url = "http://$hostname:6080/vnc_auto.html"
$user = $database['nova'][user]
$password = $database['nova'][password]
$url = " mysql://$user:$password@$hostname/nova"
$users = hiera_hash('users')
$nova_user = $users['nova'][user]
$nova_pass = $users['nova'][password]
$rabbit_pass = hiera('rabbitpass')
$neutron_user = $users['neutron'][user]
$neutron_password = $users['neutron'][password]
$neutron_url = "http://$hostname:9696"
$neutron_admin_url = "http://$hostname:5000/v2.0"
$metadata_pass = hiera('metadatapass')

statoverride { 'execute-statoverride': 
  notify => File['/etc/kernel/postinst.d/statoverride'],
}

file { '/etc/kernel/postinst.d/statoverride':
  ensure => present,
  source => 'puppet:///modules/nova/statoverride',
  mode   => 0755,
  notify => File['/usr/share/augeas/lenses/dist/pythonpaste.aug'],
}
file { '/usr/share/augeas/lenses/dist/pythonpaste.aug':
    ensure  => present,
    source  => 'puppet:///modules/keystone/lens.aug',
    mode    => 0755,
    notify => Augeas['update-nova-compute-conf-file']
  }
augeas { 'update-nova-compute-conf-file':
  context  => '/files/etc/nova/nova.conf',
  changes => [ "set database/connection $url",
               "set DEFAULT/rpc_backend  'nova.rpc.impl_kombu'",
               "set DEFAULT/rabbit_host $hostname",
               "set DEFAULT/rabbit_password $rabbit_pass",
               "set DEFAULT/auth_strategy 'keystone'",
               "set DEFAULT/my_ip $ipaddress",
               "set DEFAULT/vnc_enabled True",
               "set DEFAULT/vncserver_listen '0.0.0.0'",
               "set DEFAULT/vncserver_proxyclient_address $ipaddress",
               "set DEFAULT/novncproxy_base_url $vnc_url",
               "set DEFAULT/glance_host $hostname",
               "set DEFAULT/network_api_class 'nova.network.neutronv2.api.API'",
               "set DEFAULT/neutron_url $neutron_url",
               "set DEFAULT/neutron_auth_strategy 'keystone'",
               "set DEFAULT/neutron_admin_tenant_name 'service'",
               "set DEFAULT/neutron_admin_username $neutron_user",
               "set DEFAULT/neutron_admin_password  $neutron_password",
               "set DEFAULT/neutron_admin_auth_url $neutron_admin_url",
               "set DEFAULT/firewall_driver 'nova.virt.firewall.NoopFirewallDriver'",
               "set DEFAULT/security_group_api 'neutron'",
               "set DEFAULT/linuxnet_interface_driver 'nova.network.linux_net.LinuxOVSInterfaceDriver'",
               "set DEFAULT/libvirt_vif_driver  'nova.virt.libvirt.vif.LibvirtGenericVIFDriver'",
               "set DEFAULT/service_neutron_metadata_proxy  True",
               "set DEFAULT/neutron_metadata_proxy_shared_secret  $metadata_pass"],

  notify => Augeas['update-nova-api-conf'],
}
augeas { 'update-nova-api-conf':
  context => '/files/etc/nova/api-paste.ini',
  changes => ["set keystone_authtoken/auth_host $hostname",
              "set keystone_authtoken/auth_port  35357",
              "set keystone_authtoken/auth_protocol  'http'",
              "set keystone_authtoken/admin_tenant_name  'service'",
              "set keystone_authtoken/admin_user $nova_user",
              "set keystone_authtoken/admin_password $nova_pass"],
  notify => File['/var/lib/nova/nova.sqlite'],
}

file { '/var/lib/nova/nova.sqlite':
  ensure => absent,
  notify => Service['nova-compute'],
}

service { 'nova-compute':
  ensure => running,
  enable => true,
  require => Package['nova-compute-kvm', 'python-guestfs'],
}
}
