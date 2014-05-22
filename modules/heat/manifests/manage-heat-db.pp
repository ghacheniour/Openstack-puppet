define manage-heat-db {
  exec { 'manage-heat-db':
    command => "/usr/bin/heat-manage db_sync",
  }
}
