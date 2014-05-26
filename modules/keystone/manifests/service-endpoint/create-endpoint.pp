define create-endpoint ($admin_token, $url, $var){
$service = inline_template('<%= %x{/usr/bin/keystone --os-token=#{admin_token}  --os-endpoint=#{url}  service-list  | /bin/grep #{name}} %>')
$id = inline_template("<%= @service.slice(2,32) %>")
  exec { "create-ebdpoint-$name":
    command => "/usr/bin/keystone  --os-token=$admin_token --os-endpoint=$url endpoint-create  --publicurl=$var --internalurl=$var --adminurl=$var --service-id=$id",
    unless => "/usr/bin/keystone  --os-token=$admin_token --os-endpoint=$url endpoint-list | grep $id",
  }
}
