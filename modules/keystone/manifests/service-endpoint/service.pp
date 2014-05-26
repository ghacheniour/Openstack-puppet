class keystone::service-endpoint::service {
  require keystone::define::define
  $admin_token = hiera('admin_token')
  $hostname = hiera('hostname')
  $url = "http://${hostname}:35357/v2.0"
  create-service { ['keystone', 'glance', 'cinder', 'nova', 'neutron', 'cinderv2', 'swift', 'heat', 'heat-cfn']:
    admin_token => $admin_token,
    url => $url,
  }

}
