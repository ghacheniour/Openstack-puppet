class glance::glance-sync {
require glance::glance-conf
file { "/var/lib/glance/glance.sqlite":
    ensure => absent,
    notify =>  Manage-glance-database['manage-glance-database'],
  }
manage-glance-database { 'manage-glance-database':
  notify => Service['glance-registry','glance-api'],
 }
 service { ['glance-registry', 'glance-api']:
    ensure => running,
    enable => true,
  }
}
