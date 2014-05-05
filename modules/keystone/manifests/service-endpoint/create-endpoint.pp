define endpoint ($admin_token, $url, $publicurl, $internalurl,$adminurl ){
  exec { "create-ebdpoint-$name":
    command => "/usr/bin/keystone  --os-token=$admin_token --os-endpoint=$url endpoint-create --service-id=$service_id --publicurl=$publicurl $internalurl= $internalurl --adminurl=$adminurl",
    unless => "/usr/bin/keystone  --os-token=$admin_token --os-endpoint=$url endpoint-list | grep $service_id",
  }
}
