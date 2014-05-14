class keystone::service-endpoint::service-endpoint {
#require keystone::define::service
$admin_token = hiera('admin_token')
  $hostname = hiera('hostname')
  $url = "http://${hostname}:35357/v2.0"
  $url_keystone = "http://$hostname:35357/v2.0"
  $url_glance =  "http://$hostname:9292/"
  $url_nova =  "http://$hostname:8774/v2/%\(tenant_id\)s "
  $url_cinder = "http://$hostname:8776/v1/%\(tenant_id\)s"
  $url_neutron =  "http://$hostname:9696/"
  $url_cinderv2 = "http://$hostname:8776/v2/%\(tenant_id\)s"
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

}
