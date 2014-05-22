# this class install ntp server and start the service
class ntp::ntp {
  package { 'ntp':
    ensure => installed,
  }

  service { 'ntp':
    ensure  => running,
    enable  => true,
    require => Package['ntp'],
  }
}
