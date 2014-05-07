define nova-manage-db {
  exec { $name:
    command => "/usr/bin/nova-manage db sync",
  }
}
