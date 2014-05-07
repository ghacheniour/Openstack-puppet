class nova::nova-sync {
require nova::nova-conf
  file { '/var/lib/nova/nova.sqlite':
    ensure => absent,
  }
  nova-manage-db { 'manage-database': 
    notify => Service['nova-api',
                      'nova-cert',
                      'nova-consoleauth',
                      'nova-scheduler',
                      'nova-conductor',
                      'nova-novncproxy'],
  }

 service { ['nova-api',
             'nova-cert',
             'nova-consoleauth',
             'nova-scheduler',
             'nova-conductor',
             'nova-novncproxy']:
    ensure  => running,
    enable  => true,
    require => Package['nova-novncproxy',
                       'novnc',
                       'nova-api',
                       'nova-ajax-console-proxy',
                       'nova-cert',
                       'nova-conductor',
                       'nova-consoleauth',
                       'nova-doc',
                       'nova-scheduler',
                       'python-novaclient'],
  }

}
