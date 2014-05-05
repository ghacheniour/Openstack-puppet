class keystone::service-endpoint::service-endpoint {
$admin_token = hiera('admin_token')
  $group = ["keystone", "glance", "cinder", "nova", "neutron"]
  $hostname = hiera('hostname')
  $url = "http://${hostname}:35357/v2.0"
  create-service { ['keystone','glance','cinder','nova','neutron']:
    admin_token => $admin_token,
    url => $url,
  }  
  create-endpoint {
    admin_token => $admin_token, 
    url         => $url, 
    service_id  => , 
    publicurl   => "http://$hostname:35357/v2.0", 
    internalurl => "http://$hostname:5000/v2.0",
    adminurl    => "http://$hostname:35357/v2.0",
  }
}
