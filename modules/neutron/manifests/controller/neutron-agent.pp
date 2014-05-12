class neutron::controller::neutron-agent {
$users = hiera_hash('users')
$neutron_user = $users['neutron'][user]
$neutron_pass = $users['neutron'][password]
$hostname = hiera('hostname')
$neutron_admin_url = "http://$hostname:5000/v2.0"
$metadata_pass = hiera('metadatapass')
sed-sysctl { 'update-dhcp-interface_driver':
  attribute => '# interface_driver = neutron.agent.linux.interface.OVSInterfaceDriver',
  new_attribute => 'interface_driver = ',
  path => '/etc/neutron/dhcp_agent.ini',
  notify => Sed-sysctl['update-dhcp-dhcp_driver'],
}
sed-sysctl { 'update-dhcp-dhcp_driver':
  attribute => '# dhcp_driver',
  new_attribute => 'dhcp_driver ',
  path => '/etc/neutron/dhcp_agent.ini',
  notify => Sed-sysctl['update-dhcp-use_namespaces'],
}
sed-sysctl { 'update-dhcp-use_namespaces':
  attribute => '# use_namespaces ',
  new_attribute => 'use_namespaces ',
  path => '/etc/neutron/dhcp_agent.ini',
  notify => Augeas['update-dhcp-agent'],
}


augeas { 'update-dhcp-agent':
  context => '/files/etc/neutron/dhcp_agent.ini/DEFAULT',
  changes => ["set interface_driver neutron.agent.linux.interface.OVSInterfaceDriver",
             "set dhcp_driver neutron.agent.linux.dhcp.Dnsmasq",
             "set use_namespaces True"],
}
sed-sysctl { 'update-l3-agent-interface_driver ':
  attribute => '# interface_driver = neutron.agent.linux.interface.OVSInterfaceDriver',
  new_attribute => 'interface_driver = ',
  path => '/etc/neutron/l3_agent.ini',
  notify => Sed-sysctl['update-l3-agent-use_namespaces'],
}
sed-sysctl { 'update-l3-agent-use_namespaces':
  attribute => '# use_namespaces',
  new_attribute => 'use_namespaces',
  path => '/etc/neutron/l3_agent.ini',
  notify =>  Augeas['update-l3-agent'],
}

augeas { 'update-l3-agent':
  context => '/files/etc/neutron/l3_agent.ini/DEFAULT',
  changes => ["set interface_driver neutron.agent.linux.interface.OVSInterfaceDriver",
             "set use_namespaces True"],
}
sed-sysctl { 'update-nova_metadata_ip ':
  attribute => '# nova_metadata_ip',
  new_attribute => 'nova_metadata_ip',
  path => '/etc/neutron/metadata_agent.ini',
  notify => Sed-sysctl['update-nova_metadata_port'],
}
sed-sysctl { 'update-nova_metadata_port':
  attribute => '# nova_metadata_port',
  new_attribute => 'nova_metadata_port',
  path => '/etc/neutron/metadata_agent.ini',
  notify => Sed-sysctl['update-metadata_proxy_shared_secret'],
}
sed-sysctl { 'update-metadata_proxy_shared_secret':
  attribute => '# metadata_proxy_shared_secret',
  new_attribute => 'metadata_proxy_shared_secret',
  path => '/etc/neutron/metadata_agent.ini',
  notify => Augeas['update-metadata-agent'],
}
augeas { 'update-metadata-agent':
  context => '/files/etc/neutron/metadata_agent.ini/DEFAULT',
  changes => ["set  admin_tenant_name 'service'",
               "set admin_user $neutron_user",
               "set admin_password $neutron_pass",
               "set auth_url $neutron_admin_url",
               "set nova_metadata_port 8775",
               "set nova_metadata_ip $hostname",
               "set auth_region 'regionOne'",
               "set metadata_proxy_shared_secret $metadata_pass"],
}
}
