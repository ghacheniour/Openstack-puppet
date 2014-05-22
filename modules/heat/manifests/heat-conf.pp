class heat::heat-conf {
$database = hiera_hash('database')
$db_user = $database["heat"][user]
$db_pass = $database["heat"][password]
$hostname = hiera('hostname')
$sql_url = "mysql://${db_user}:${db_pass}@${hostname}/heat"
$users = hiera_hash('users')
$user = $users["heat"][user]
$pass = $users["heat"][password]
$rabbit_pass = hiera('rabbitpass')
$auth_url = "http://${hostname}:5000/v2.0"
$ec2_url = "http://${hostname}:5000/v2.0/ec2tokens"
augeas { 'update-sql-connection-url': 
  context => '/files/etc/heat/heat.conf/DEFAULT',
  changes => "set sql_connection $sql_url",
  notify => File['/var/lib/heat/heat.sqlite'],
}
file { '/var/lib/heat/heat.sqlite':
  ensure => absent,
  notify => Manage-heat-db['manage-heat-db'],
}
manage-heat-db { 'manage-heat-db': 
  notify => Sed-heat['update-verbose']}
sed-heat { 'update-verbose':
  attribute => '#verbose',
  new_attribute => 'verbose',
  notify => Sed-heat['update-log_dir'],
  
}
sed-heat { 'update-log_dir':
  attribute => '#log_dir',
  new_attribute => 'log_dir',
  notify => Augeas['update-verbose-log-attribute'],
}
augeas { 'update-verbose-log-attribute':
  context => '/files/etc/heat/heat.conf/DEFAULT',
  changes => ["set verbose True",
              "set log_dir '/var/log/heat'"],
  notify => Sed-heat['update-rabbit-host'],
}
sed-heat { 'update-rabbit-host':
  attribute => '#rabbit_host',
  new_attribute => 'rabbit_host',
  notify => Sed-heat['update-rabbit-pass'],
}
sed-heat { 'update-rabbit-pass':
  attribute => '#rabbit_password',
  new_attribute => 'rabbit_password',
  notify => Augeas['update-rabbit-host-pass-attribute'],
}
augeas { 'update-rabbit-host-pass-attribute':
  context => '/files/etc/heat/heat.conf/DEFAULT',
  changes => ["set rabbit_host $hostname",
              "set rabbit_password $rabbit_pass"],
  notify => Augeas['update-keystone_auth-section'],
}
augeas { 'update-keystone_auth-section':
  context => '/files/etc/heat/heat.conf/keystone_authtoken/',
  changes => ["set auth_host $hostname",
              "set auth_port 35357",
              "set auth_protocol http",
              "set auth_uri $auth_url",
              "set admin_tenant_name 'service'",
              "set admin_user $user",
              "set admin_password $pass"],
}
sed-heat { 'update-auth-uri':
  attribute => "#auth_uri",
  new_attribute => "auth_uri",
  notify => Augeas['updateec2authtoken']
}
augeas { 'updateec2authtoken':
  context => '/files/etc/heat/heat.conf/ec2authtoken',
  changes => ["set auth_uri $auth_url",
              "set keystone_ec2_uri $ec2_url"],
}
}
