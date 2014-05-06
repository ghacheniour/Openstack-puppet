define manage-glance-database {
  exec { $name:
    command => "/usr/bin/glance-manage db_sync",
  }
}
