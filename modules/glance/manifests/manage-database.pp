define manage-database {
  exec { $name:
    command => "/usr/bin/glance-manage db_sync",
  }
}
