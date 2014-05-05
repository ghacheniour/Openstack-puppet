class keystone::service-endpoint::service-endpoint {
$admin_token = hiera('admin_token')
  $group = ["keystone", "glance", "cinder", "nova", "neutron"]
  $hostname = hiera('hostname')
  $url = "http://${hostname}:35357/v2.0"
  create-service { ['keystone','glance','cinder','nova','neutron']:
    admin_token => $admin_token,
    url => $url,
  }  
  create-endpoint { 'keystone':
    admin_token => $admin_token, 
    url         => $url,
    publicurl   => "http://$hostname:35357/v2.0", 
    internalurl => "http://$hostname:5000/v2.0",
    adminurl    => "http://$hostname:35357/v2.0",
  }
  create-endpoint { 'glance':
    admin_token => $admin_token,
    url         => $url,
    publicurl   => "http://$hostname:9292",
    internalurl => "http://$hostname:9292",
    adminurl    => "http://$hostname:9292",
  }
  create-endpoint { 'nova':
    admin_token => $admin_token,
    url         => $url,
    publicurl   => "http://$hostname::8774/v2/%\(tenant_id\)s ",
    internalurl => "http://$hostname::8774/v2/%\(tenant_id\)s ",
    adminurl    => "http://$hostname::8774/v2/%\(tenant_id\)s ",
  }
   create-endpoint { 'cinder':
    admin_token => $admin_token,
    url         => $url,
    publicurl   => "http://$hostname:8776/v1/%\(tenant_id\)s",
    internalurl => "http://$hostname:8776/v1/%\(tenant_id\)s",
    adminurl    => "http://$hostname:8776/v1/%\(tenant_id\)s",
  }
 create-endpoint { 'neutron':
    admin_token => $admin_token,
    url         => $url,
    publicurl   => "http://$hostname:9696 ",
    internalurl => "http://$hostname:9696 ",
    adminurl    => "http://$hostname:9696 ",
  }

}
