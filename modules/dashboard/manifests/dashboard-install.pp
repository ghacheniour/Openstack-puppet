class dashboard::dashboard-install {
  $hostname = hiera('hostname')
  $attribute = "OPENSTACK_HOST = \"${hostname}\""
  package { ['memcached', 'libapache2-mod-wsgi', 'openstack-dashboard']: 
    ensure => installed, 
    notify => Package["openstack-dashboard-ubuntu-theme"]
  }
  package { "openstack-dashboard-ubuntu-theme":
    ensure => "purged",
    notify => Exec['update-openstack-host'],
  }
  exec { 'update-openstack-host':
    command => "/bin/sed -i -e 's/OPENSTACK_HOST = \"127.0.0.1\"/$attribute/g' /etc/openstack-dashboard/local_settings.py",
    notify  => Service['apache2', 'memcached'],
  }
  service { ['apache2', 'memcached']: 
    ensure => running,
    enable => true,
  }
}
