class glance::glance-install {
#require keystone::service-endpoint::service-endpoint
  package { ['glance', 'python-glanceclient']: 
    ensure => installed, 
  }

 
}
