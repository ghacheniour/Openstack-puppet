class cinder::storage {
$database = hiera_hash('database')
$user_db = $database['cinder'][user]
$pass_db = $database['cinder'][password]
$hostname = hiera('hostname')
$url = "mysql://$user_db:$pass_db@$hostname/cinder"
$users = hiera_hash('users')
$user = $users['cinder'][user]
$pass = $users['cinder'][password]
$rabbit_pass = hiera('rabbitpass')
  package { 'lvm2':
    ensure => installed,
    notify => Attach-volume['attach-volume'],
  } 
  attach-volume { 'attach-volume':
    notify => Package['cinder-volume'],
  }
  package { 'cinder-volume': 
    ensure => installed,
    notify => Augeas['update-cinder-storrage-connection'],
  }
   augeas {'update-cinder-storrage-connection':
   context => '/files/etc/cinder/cinder.conf',
   changes => "set database/connection $url",
   notify => Augeas['update-cinder-storrage-api-auth'],
 }
  augeas { 'update-cinder-storrage-api-auth':
    context => '/files/etc/cinder/api-paste.ini/filter:authtoken',
    changes => ["set auth_host $hostname",
                "set admin_tenant_name 'service'",
                "set admin_user $user",
                "set admin_password $pass"],
    notify => Augeas['update-cinder-storrage-auth'],
  }
  
  augeas { 'update-cinder-storrage-auth':
    context => '/files/etc/cinder/cinder.conf/DEFAULT',
    changes => ["set rpc_backend 'cinder.openstack.common.rpc.impl_kombu'",
                "set rabbit_host $hostname",
                "set rabbit_port 5672",
                "set rabbit_userid 'guest'",
                "set rabbit_password $rabbit_pass"],
    notify => Service['cinder-volume', 'tgt'],
  }
  service { ['cinder-volume', 'tgt']:
    ensure => running,
    enable => true,
  }
}
