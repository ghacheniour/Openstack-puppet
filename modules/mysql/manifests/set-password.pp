define set-password($password) { 
  exec { "set-${name}":
    unless => "/usr/bin/mysqladmin -uroot -p${password} status",
    command => "/usr/bin/mysqladmin -uroot password ${password}",
    require => Service['mysql'],
  }
}
