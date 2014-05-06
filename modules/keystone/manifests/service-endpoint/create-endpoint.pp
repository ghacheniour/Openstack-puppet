define create-endpoint ($admin_token, $url, $var){
$id = id($admin_token, $url, $name)
  exec { "create-ebdpoint-$name":
    command => "/usr/bin/keystone  --os-token=$admin_token --os-endpoint=$url endpoint-create  --publicurl=$var --internalurl=$var --adminurl=$var --service-id=$id",
    unless => "/usr/bin/keystone  --os-token=$admin_token --os-endpoint=$url endpoint-list | grep $id",
  }
}
