define attach-volume {
$path = hiera('cinder_drivers')
notify { $path: }
exec { 'pvcreate':
  command => "/sbin/pvcreate $path",
  notify => Exec['vgcreate'],
 }
exec { 'vgcreate':
  command => "/sbin/vgcreate cinder-volumes $path",
}
}
