define create-endpoint-swift ($admin_token, $url, $var, $var2){
$service = inline_template('<%= %x{/usr/bin/keystone --os-token=#{admin_token} --os-endpoint=#{url} service-list | /bin/grep #{name}} %>')
$id = inline_template("<%= @service.slice(2,32) %>")
  exec { "create-endpoint-$name":
    command => "/usr/bin/keystone  --os-token=$admin_token --os-endpoint=$url endpoint-create  --publicurl=$var --internalurl=$var --adminurl=$var2 --service-id=$id",
    unless => "/usr/bin/keystone  --os-token=$admin_token --os-endpoint=$url endpoint-list | grep $id",
  }
}
