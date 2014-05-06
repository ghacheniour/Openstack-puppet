# install havana repository
class havana-repository::havana-repository {
  
   package { 'python-software-properties':
    ensure => installed,
  }
  
  exec { 'add-havana-repository':
    command => '/usr/bin/add-apt-repository cloud-archive:havana',
    require => Package['python-software-properties'],
  }
  
  exec { 'ubuntu-update':
    command => '/usr/bin/apt-get update && /usr/bin/apt-get -y dist-upgrade',
    require => Exec['add-havana-repository'],
    timeout => 0,
  }
}
