# this file ensure authentification
define creditionals {
  $admin_token = hiera('admin_token')
  $hostname = hiera('hostname')
  $url = "http://${hostname}:35357/v2.0"
  file { '/root/openrc.sh':
    ensure => present,
    content => template('keystone/source.erb'),
    mode => 0755,
  }
}
