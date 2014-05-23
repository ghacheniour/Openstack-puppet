class neutron::compute::compute-sysctl {
sed-compute { 'uncomment-all.rp_filter':
  attribute => '#net.ipv4.conf.all.rp_filter=1',
  new_attribute => 'net.ipv4.conf.all.rp_filter=1',
  path => '/etc/sysctl.conf',
  notify => Sed-compute['uncomment-default.rp_filter'],
}
sed-compute { 'uncomment-default.rp_filter':
  attribute => '#net.ipv4.conf.default.rp_filter=1',
  new_attribute => 'net.ipv4.conf.default.rp_filter=1',
  path => '/etc/sysctl.conf',
  notify => Augeas['update-compute-sysctl'],
}
augeas { 'update-compute-sysctl':
  context => '/files/etc/sysctl.conf',
  changes => ["set net.ipv4.conf.all.rp_filter 0",
              "set net.ipv4.conf.default.rp_filter 0"],
  notify => Service['networking'],
}
service { 'networking':
  ensure => running,
}
}
