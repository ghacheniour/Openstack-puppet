define tenant-create ($admin_token, $url, $tenant_name, $desc) { 
  exec { $name:
    command => "/usr/bin/keystone --os-token=$admin_token --os-endpoint=$url tenant-create --name=$tenant_name --description=\"$desc\"",
    unless => "/usr/bin/keystone  --os-token=$admin_token --os-endpoint=$url tenant-list |grep $tenant_name",
  }
}
