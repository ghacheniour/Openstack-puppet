class nova::controller::nova-install {
  package { ['nova-novncproxy', 
             'novnc', 
             'nova-api', 
             'nova-ajax-console-proxy',
             'nova-cert',
             'nova-conductor', 
             'nova-consoleauth',
             'nova-doc',
             'nova-scheduler',
             'python-novaclient']:
    ensure => installed,
  }
  

 }
