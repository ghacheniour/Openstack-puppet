define cinder-manage-db {
  exec { $name:
    command => "/usr/bin/cinder-manage db sync",
  }
}
