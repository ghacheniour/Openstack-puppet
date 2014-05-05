define usr-role-add ($admin_token, $url, $tenant, $role){
  exec { "add-role-to-usr-$name":
    command => "/usr/bin/keystone  --os-token=$admin_token --os-endpoint=$url user-role-add --user=$name --tenant=$tenant --role=$role",
    unless => "/usr/bin/keystone  --os-token=$admin_token --os-endpoint=$url user-role-list --user $name --tenant $tenant",
  }
}
