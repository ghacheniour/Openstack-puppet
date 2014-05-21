define create-node  {
$path=""${name}1"
file { "/srv/node/$path":
  ensure => directory,
  recurse => true,
  require => File['/srv/node/'],
  owner => 'swift',
  group => 'swift',
}
}
