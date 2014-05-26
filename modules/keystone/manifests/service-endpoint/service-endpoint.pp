class keystone::service-endpoint::service-endpoint {
#require keystone::service-endpoint::service
$admin_token = hiera('admin_token')
  $hostname = hiera('hostname')
  $url = "http://${hostname}:35357/v2.0"
  $url_keystone = "http://$hostname:35357/v2.0"
  $url_glance =  "http://$hostname:9292/"
  $url_nova =  "http://$hostname:8774/v2/%\(tenant_id\)s "
  $url_cinder = "http://$hostname:8776/v1/%\(tenant_id\)s"
  $url_neutron =  "http://$hostname:9696/"
  $url_cinderv2 = "http://$hostname:8776/v2/%\(tenant_id\)s"
  $url_swift  = "http://$hostname:8080/v1/AUTH_%\(tenant_id\)s"
  $url_swift_admin = "http://$hostname:8080"
  $url_heat  = "http://$hostname:8004/v1/%\(tenant_id\)s"
  $url_heat_cfn = "http://$hostname:8000/v1"
  create-endpoint { 'keystone':
    admin_token => $admin_token, 
    url         => $url,
    var         =>  $url_keystone,
  }
  create-endpoint { 'glance':
    admin_token => $admin_token,
    url         => $url,
    var         => $url_glance,
  }
  create-endpoint { 'nova':
    admin_token => $admin_token,
    url         => $url,
    var         => $url_nova,
  }
   create-endpoint { 'cinder':
    admin_token => $admin_token,
    url         => $url,
    var         => $url_cinder,
  }
 create-endpoint { 'neutron':
    admin_token => $admin_token,
    url         => $url,
    var         => $url_neutron,
  }
  create-endpoint { 'cinderv2':
    admin_token => $admin_token,
    url         => $url,
    var         => $url_cinderv2,
  }
  create-endpoint-swift { 'swift':
    admin_token => $admin_token,
    url         => $url,
    var         => $url_swift,
    var2        => $url_swift_admin,
  }
  create-endpoint { 'heat':
    admin_token => $admin_token,
    url         => $url,
    var         => $url_heat,
  }
  create-endpoint { 'heat-cfn':
    admin_token => $admin_token,
    url         => $url,
    var         => $url_heat_cfn,
  }
}
