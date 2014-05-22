# this ressource create database, users and attribute grants.
define create-db {
  $database = hiera_hash('database')
  $usr = $database[$name][user]
  $password = $database[$name][password]
    exec { "create-${name}-db":
      unless  => "/usr/bin/mysql -u${usr} -p${password} ${name}",
      command => "/usr/bin/mysql -uroot -popenstackdb -e \"create database ${name};grant all on ${name}.* to '$usr'@'localhost' identified by '$password';grant all on ${name}.* to '$usr'@'%' identified by '$password'\"",
    }
  }
