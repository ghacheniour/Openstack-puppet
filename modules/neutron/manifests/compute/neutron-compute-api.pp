class neutron::compute::neutron-compute-api {
$hostname = hiera('hostname')
$users = hiera_hash('users')
$neutron_user = $users['neutron'][user]
$neutron_password = $users['neutron'][password]
$file = "/files/etc/neutron/api-paste.ini/filterauthtoken"
sed-compute-api { 'update-filter-uthtoken':
  attribute => 'filter_factory$',
  new_attribute => "filter_factory\\nauth_host = $hostname \\nadmin_user = $neutron_user \\nadmin_password = $neutron_password \\nadmin_tenant_name = service",
  path => '/etc/neutron/api-paste.ini',
}
}
