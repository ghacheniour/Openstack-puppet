# this class install and configure the keystone service
class keystone::install::install {
require mysql::mysql-create-db
  $admin_token = hiera('admin_token')
  package { [ 'keystone' ]:
    ensure => installed,
    notify => File['/usr/share/augeas/lenses/dist/pythonpaste.aug'],
  }

  service { 'keystone':
    ensure => running,
    enable => true,
  }

  sed { 'update-admin-token':
    attribute     => '# admin_token',
    new_attribute => 'admin_token',
    path          => '/etc/keystone/keystone.conf',
    notify        => Augeas['update-admin-token'],
  }

  augeas { 'update-admin-token':
    context => '/files/etc/keystone/keystone.conf/DEFAULT',
    changes => "set admin_token $admin_token",
    notify  => Mysql['create-url'],
  }

  mysql { 'create-url':
    module => 'keystone',
    notify => File['/var/lib/keystone/keystone.db'],
  }

  manage-database { 'manage-keystone-database':
    notify => Service['keystone'],
  }
  file { '/var/lib/keystone/keystone.db':
    ensure => absent,
    notify =>  Manage-database['manage-keystone-database'],
  }

  file { '/usr/share/augeas/lenses/dist/pythonpaste.aug':
    ensure => present,
    source => 'puppet:///modules/keystone/lens.aug',
    mode   => '0755',
    notify =>  Sed['update-admin-token'],
  }
}
