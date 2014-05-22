# this define create users
define user-create ($admin_token, $url) {
  $users = hiera_hash ('users')
  $user = $users[$name][user]
  $password = $users[$name][password]
  $email = $users[$name][email]

  exec { "create-user-$name":
    command => "/usr/bin/keystone --os-token=$admin_token --os-endpoint=$url user-create --name=$user --pass=$password --email=$email",
    unless  => "/usr/bin/keystone --os-token=$admin_token --os-endpoint=$url user-list | grep $user",
  }
}
