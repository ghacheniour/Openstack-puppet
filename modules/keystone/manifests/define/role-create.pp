# this define create roles
define role-create ($admin_token, $url, $role) {
  exec { $name:
    command => "/usr/bin/keystone --os-token=$admin_token --os-endpoint=$url role-create --name=$role",
    unless => "/usr/bin/keystone --os-token=$admin_token --os-endpoint=$url role-list | grep $role",
  }
}
