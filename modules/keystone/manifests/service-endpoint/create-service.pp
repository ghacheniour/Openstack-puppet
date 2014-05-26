define create-service ($admin_token, $url){
  $services = hiera_hash('services')
  $type = $services[$name][type]
  $desc = $services[$name][description]
  notify { $name: }
  exec { "create-service-$name":
    command => "/usr/bin/keystone  --os-token=$admin_token --os-endpoint=$url service-create --name=$name --type=$type --description=\"$desc\"",
  }
} 
