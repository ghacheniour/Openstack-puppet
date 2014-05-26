define create-endpoint ($admin_token, $url, $var){
  exec { "create-ebdpoint-$name":
    command => "/usr/bin/keystone  --os-token=$admin_token --os-endpoint=$url endpoint-create  --publicurl=$var --internalurl=$var --adminurl=$var --service=$name",
    unless => "/usr/bin/keystone  --os-token=$admin_token --os-endpoint=$url endpoint-list | grep $var",
  }
}
