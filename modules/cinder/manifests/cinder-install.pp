class cinder::cinder-install {
$database = hiera_hash('database')
$user_db = $database['cinder'][user]
$pass_db = $database['cinder'][password]
$hostname = hiera('hostname')
$url = "mysql://$user_db:$pass_db@$hostname/cinder"
$users = hiera_hash('users')
$user = $users['cinder'][user]
$pass = $users['cinder'][password]
$rabbit_pass = hiera('rabbitpass')
  package { ['cinder-api' ,'cinder-scheduler']:
    ensure => installed,
    notify => Augeas['update-cinder-connection'],
  }

  augeas {'update-cinder-connection':
   context => '/files/etc/cinder/cinder.conf',
   changes => "set database/connection $url",
   notify  => Cinder-manage-db['cinder-manage-database'],
 }
  cinder-manage-db { 'cinder-manage-database':
    notify => Augeas['update-cinder-api-auth'],
 }

  augeas { 'update-cinder-api-auth':
    context => '/files/etc/cinder/api-paste.ini/filter:authtoken',
    changes => ["set auth_host $hostname",
                "set admin_tenant_name 'service'",
                "set admin_user $user",
                "set admin_password $pass"],
    notify => Augeas['update-cinder-auth'],
  }
  
  augeas { 'update-cinder-auth':
    context => '/files/etc/cinder/cinder.conf/DEFAULT',
    changes => ["set rpc_backend  'cinder.openstack.common.rpc.impl_kombu'",
                "set rabbit_host $hostname",
                "set rabbit_port  5672",
                "set rabbit_userid  'guest'",
                "set rabbit_password $rabbit_pass"],
    notify => Service['cinder-scheduler', 'cinder-api'],
  }

  service { ['cinder-scheduler', 'cinder-api']:  
    ensure => running,
    enable => true,
  }
}
