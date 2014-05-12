class neutron::controller::neutron-conf {
#require neutron::controller::sysctl
$rabbitpass = hiera('rabbitpass')
$hostname = hiera('hostname')
$users = hiera_hash('users')
$database = hiera_hash('database')
$user = $database['neutron'][user]
$password = $database['neutron'][password]
$url = " mysql://$user:$password@$hostname/neutron"
$neutron_user = $users['neutron'][user]
$neutron_password = $users['neutron'][password]
sed-sysctl { 'update-service-plugins':
  attribute    => '# service_plugins',
  new_attribute => 'service_plugins',
  path         => '/etc/neutron/neutron.conf',
  notify       => Sed-sysctl['commentservice_providers'],
}
sed-sysctl { 'commentservice_providers':
  attribute     => 'service_provider=LOADBALANCER:Haproxy:neutron.services.loadbalancer.drivers.haproxy.plugin_driver.HaproxyOnHostPluginDriver:default',
  new_attribute => '#service_provider=LOADBALANCER:Haproxy:neutron.services.loadbalancer.drivers.haproxy.plugin_driver.HaproxyOnHostPluginDriver:default',
  path          => '/etc/neutron/neutron.conf',
  notify        => Sed-sysctl['uncomment-api_paste_config'],
}
sed-sysctl { 'uncomment-api_paste_config':
  attribute     => '# api_paste_config',
  new_attribute => 'api_paste_config  ',
  path          => '/etc/neutron/neutron.conf',
  notify        => Sed-sysctl['uncomment-overlapping-ips'],
}
sed-sysctl { 'uncomment-overlapping-ips':
  attribute     => '# allow_overlapping_ips ',
  new_attribute => 'allow_overlapping_ips  ',
  path          => '/etc/neutron/neutron.conf',
  notify        => Augeas['update-neutron-conf'],
}
sed-sysctl { 'uncomment-rabbit-guest':
  attribute     => '# rabbit_host ',
  new_attribute => 'rabbit_host ',
  path          => '/etc/neutron/neutron.conf',
  notify        => Sed-sysctl['uncomment-rabbit-pass'],
}
sed-sysctl { 'uncomment-rabbit-pass':
  attribute     => '# rabbit_password',
  new_attribute => 'rabbit_password',
  path          => '/etc/neutron/neutron.conf',
  notify        => Sed-sysctl['uncomment-rabbit-user'],
}
sed-sysctl { 'uncomment-rabbit-user':
  attribute => '# rabbit_userid ',
  new_attribute => 'rabbit_userid ',
  path          => '/etc/neutron/neutron.conf',
  notify        => Sed-sysctl['comment-database-connection'],
}
sed-sysctl { 'comment-database-connection':
  attribute     => "connection = sqlite:\/\/\/\/var\/lib\/neutron\/neutron.sqlite",
  new_attribute => "# connection = sqlite:\/\/\/\/var\/lib\/neutron\/neutron.sqlite",
  path          => '/etc/neutron/neutron.conf',
  notify        => Augeas['update-neutron-conf'],
}

augeas { 'update-neutron-conf':
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
