define swift-ring-builder-create {
$builder = "${name}.builder"
exec { "swift-ring-builder-create-$name":
  command => "/usr/bin/swift-ring-builder $builder create 18 3 1",
  cwd     => "/etc/swift/",
}
}
