define attach-volume {
$path = hiera('path_to_cinder_volume')
notify { $path: }
exec { 'pvcreate':
  command => "/sbin/pvcreate $path",
  notify => Exec['vgcreate'],
 }
exec { 'vgcreate':
  command => "/sbin/vgcreate cinder-volumes $path",
}
}
