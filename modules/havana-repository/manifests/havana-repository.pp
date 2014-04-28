# install havana repository
class havana-repository::havana-repository {
  
   package { 'python-software-properties':
    ensure => installed,
  }
  
  notify { "pyhon software has been succesfully installed": }

  exec { 'add-havna-repository':
    command => '/usr/bin/add-apt-repository cloud-archive:havana',
    require => Package['python-software-properties'],
  }
  
  notify { 'cloud archive havana were succefully deployed': }
  
  exec { 'ubuntu-update':
    command => '/usr/bin/apt-get update && /usr/bin/apt-get -y dist-upgrade',
    require => Exec['add-havna-repository'],
  }
    
  notify { " $::operatingsystem successfully upgraded": }
}
