class glance::glance-conf {
require glance::glance-install
$database = hiera_hash('database')
$hostname = hiera('hostname')
$db_user = $database['glance'][user]
$db_pass = $database['glance'][password]
$url = " mysql://$db_user:$db_pass@$hostname/glance"
$user = hiera_hash('users')
$keystone_user = $user['glance'][user]
$keystone_password = $user['glance'][password]
$augeas_path = "/files$path"
augeas { 'update-glance-api':
  context => '/files/etc/glance/glance-api.conf',
  changes => ["set DEFAULT/sql_connection $url",
              "set keystone_authtoken/auth_host $hostname",
              "set keystone_authtoken/admin_tenant_name service",
              "set keystone_authtoken/admin_user $keystone_user",
              "set keystone_authtoken/admin_password $keystone_password",
              'set paste_deploy/#comment[7] "flavor = keystone"'],             
  notify => Sed['update-glance-api-flavor'],
  }
sed { 'update-glance-api-flavor':
  attribute => "#flavor = keystone",
  new_attribute => "flavor = keystone",
  path => '/etc/glance/glance-api.conf',  
}


augeas { 'update-glance-registery':
  context => '/files/etc/glance/glance-registry.conf',
  changes => ["set DEFAULT/sql_connection $url",
              "set keystone_authtoken/auth_host $hostname",
              "set keystone_authtoken/admin_tenant_name service",
              "set keystone_authtoken/admin_user $keystone_user",
              "set keystone_authtoken/admin_password $keystone_password",
              'set paste_deploy/#comment[7] "flavor = keystone"'],
  notify => Sed['update-glance-registry-flavor'],
  }
sed { 'update-glance-registry-flavor':
  attribute => "#flavor = keystone",
  new_attribute => "flavor = keystone",
  path => '/etc/glance/glance-registry.conf',
}
  augeas { 'update-glance-api-paste':
    context => '/files/etc/glance/glance-api-paste.ini/filter:authtoken/',
    changes => ["set auth_host $hostname",
                "set admin_user  $keystone_user",
                "set admin_password $keystone_password",
                "set /admin_tenant_name service"],
  }
 
  augeas { 'update-glance-registry-paste':
    context => '/files/etc/glance/glance-registry-paste.ini/filter:authtoken/',
    changes => ["set auth_host $hostname",
                "set admin_user  $keystone_user",
                "set admin_password $keystone_password",
                "set /admin_tenant_name service"],
  }



}
