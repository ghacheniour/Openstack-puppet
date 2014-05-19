define create-endpoint-swift ($admin_token, $url, $var, $var2){
$id = id($admin_token, $url, $name)
  exec { "create-ebdpoint-$name":
    command => "/usr/bin/keystone  --os-token=$admin_token --os-endpoint=$url endpoint-create  --publicurl=$var --internalurl=$var --adminurl=$var2 --service-id=$id",
    unless => "/usr/bin/keystone  --os-token=$admin_token --os-endpoint=$url endpoint-list | grep $id",
  }
}
