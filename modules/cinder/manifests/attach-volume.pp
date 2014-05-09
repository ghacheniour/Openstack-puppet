define attach-volume {
$path = hiera('path_to_cinder_volume')
notify { $path: }
$code = attach($path)
}
