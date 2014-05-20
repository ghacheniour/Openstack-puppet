define swift-ring-builder-rebalance {
$builder = "${name}.builder"
exec { "swift-ring-builder-rebalance-$name":
  command => "/usr/bin/swift-ring-builder $builder rebalance",
  cwd      => '/etc/swift',
}
}

