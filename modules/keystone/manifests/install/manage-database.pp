# this define manage database
define manage-database {
  exec { $name:
    command => '/usr/bin/keystone-manage db_sync',
  }
}
