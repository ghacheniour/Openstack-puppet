class cinder::storage {
  require cinder::cinder-install
  package { 'lvm2':
    ensure => installed,
    notify => Attach-volume['attach-volume'],
  } 
  attach-volume { 'attach-volume':
    notify => Package['cinder-volume'],
  }
  package { 'cinder-volume': 
    ensure => installed,
    notify => Service['cinder-volume', 'tgt'],
  }
  service { ['cinder-volume', 'tgt']:
    ensure => running,
    enable => true,
  }
}
