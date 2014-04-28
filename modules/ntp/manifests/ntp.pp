class ntp::ntp {
  package { 'ntp':  
    ensure => installed,
  }

  service { 'ntp':
    ensure => running,
    require => Package['ntp'],
  }
}
  
