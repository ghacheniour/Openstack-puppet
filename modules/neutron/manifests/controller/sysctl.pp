class neutron::controller::sysctl {
require neutron::controller::neutron-install
sed-sysctl { 'uncomment-ip_forward':
  attribute     =>  '#net.ipv4.ip_forward=1',
  new_attribute =>  'net.ipv4.ip_forward=1',
  path          =>  '/etc/sysctl.conf',
  notify        => Sed-sysctl['uncomment-all.rp_filter'],
}
sed-sysctl { 'uncomment-all.rp_filter':
  attribute     =>  '#net.ipv4.conf.all.rp_filter=1',
  new_attribute =>  'net.ipv4.conf.all.rp_filter=1',
  path          =>  '/etc/sysctl.conf',
  notify        => Sed-sysctl['uncomment-default.rp_filter'],
}
sed-sysctl { 'uncomment-default.rp_filter':
  attribute     =>  '#net.ipv4.conf.default.rp_filter=1',
  new_attribute =>  'net.ipv4.conf.default.rp_filter=1',
  path          =>  '/etc/sysctl.conf',
  notify        => Augeas['update-sysctl'],
}
augeas { 'update-sysctl':
  context => '/files//etc/sysctl.conf',
  changes => ["set net.ipv4.conf.all.rp_filter 0",
              "set net.ipv4.conf.default.rp_filter 0"],
  notify  => Service['networking'],
}
service { 'networking':
  ensure => running,
}
}
