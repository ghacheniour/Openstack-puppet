# this define writes keystone sql in the keystone.conf file
define mysql ($module) {
  $hostname = hiera('hostname')
  $database = hiera_hash('database')
  $url = " mysql://${database[$module][user]}:${database[$module][password]}@${hostname}/${module}"
  augeas { $name:
    context => '/files/etc/keystone/keystone.conf/sql',
    changes => ["set connection $url"],
  }
}
