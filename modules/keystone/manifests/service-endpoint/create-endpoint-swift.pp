define create-endpoint-swift ($admin_token, $url, $var, $var2){
  exec { "create-endpoint-$name":
    command => "/usr/bin/keystone  --os-token=$admin_token --os-endpoint=$url endpoint-create  --publicurl=$var --internalurl=$var --adminurl=$var2 --service=$name",
    unless => "/usr/bin/keystone  --os-token=$admin_token --os-endpoint=$url endpoint-list | grep $var",
  }
}
