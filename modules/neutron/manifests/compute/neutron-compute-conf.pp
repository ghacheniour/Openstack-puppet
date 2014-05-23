class neutron::compute::neutron-compute-conf {
$rabbitpass = hiera('rabbitpass')
$hostname = hiera('hostname')
$users = hiera_hash('users')
$database = hiera_hash('database')
$user = $database['neutron'][user]
$password = $database['neutron'][password]
$url = " mysql://$user:$password@$hostname/neutron"
$neutron_user = $users['neutron'][user]
$neutron_password = $users['neutron'][password]
sed-compute { 'update-service-plugins':
  attribute => '# service_plugins',
  new_attribute => 'service_plugins',
  path => '/etc/neutron/neutron.conf',
  notify => Sed-compute['commentservice_providers'],
}
sed-compute { 'commentservice_providers':
  attribute => 'service_provider=LOADBALANCER:Haproxy:neutron.services.loadbalancer.drivers.haproxy.plugin_driver.HaproxyOnHostPluginDriver:default',
  new_attribute => '#service_provider=LOADBALANCER:Haproxy:neutron.services.loadbalancer.drivers.haproxy.plugin_driver.HaproxyOnHostPluginDriver:default',
  path => '/etc/neutron/neutron.conf',
  notify => Sed-compute['uncomment-api_paste_config'],
}
sed-compute { 'uncomment-api_paste_config':
  attribute => '# api_paste_config',
  new_attribute => 'api_paste_config ',
  path => '/etc/neutron/neutron.conf',
  notify => Sed-compute['uncomment-overlapping-ips'],
}
sed-compute { 'uncomment-overlapping-ips':
  attribute => '# allow_overlapping_ips ',
  new_attribute => 'allow_overlapping_ips ',
  path => '/etc/neutron/neutron.conf',
  notify => Sed-compute['uncomment-rabbit-guest'],
}
sed-compute { 'uncomment-rabbit-guest':
  attribute => '# rabbit_host ',
  new_attribute => 'rabbit_host ',
  path => '/etc/neutron/neutron.conf',
  notify => Sed-compute['uncomment-rabbit-pass'],
}
sed-compute { 'uncomment-rabbit-pass':
  attribute => '# rabbit_password',
  new_attribute => 'rabbit_password',
  path => '/etc/neutron/neutron.conf',
  notify => Sed-compute['uncomment-rabbit-user'],
}
sed-compute { 'uncomment-rabbit-user':
  attribute => '# rabbit_userid ',
  new_attribute => 'rabbit_userid ',
  path => '/etc/neutron/neutron.conf',
  notify => Sed-compute['comment-database-connection'],
}
sed-compute { 'comment-database-connection':
  attribute => "connection = sqlite:\/\/\/\/var\/lib\/neutron\/neutron.sqlite",
  new_attribute => "# connection = sqlite:\/\/\/\/var\/lib\/neutron\/neutron.sqlite",
  path => '/etc/neutron/neutron.conf',
  notify => Augeas['update-neutron-compute-conf'],
}

augeas { 'update-neutron-compute-conf':
  context => '/files/etc/neutron/neutron.conf',
  changes => ["set DEFAULT/core_plugin 'neutron.plugins.ml2.plugin.Ml2Plugin'",
              "set DEFAULT/service_plugins 'neutron.services.l3_router.l3_router_plugin.L3RouterPlugin'",
              "set DEFAULT/api_paste_config '/etc/neutron/api-paste.ini'",
              "set DEFAULT/allow_overlapping_ips True",
              "set DEFAULT/rabbit_host $hostname",
              "set DEFAULT/rabbit_userid 'guest'",
              "set DEFAULT/rabbit_password $rabbitpass",
              "set keystone_authtoken/auth_host $hostname",
              "set keystone_authtoken/admin_tenant_name 'service'",
              "set keystone_authtoken/admin_user $neutron_user",
              "set keystone_authtoken/admin_password $neutron_password"],
}
}

