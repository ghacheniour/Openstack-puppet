class mysql::mysql-create-db () {
create-db { 'cinder': }
create-db { 'neutron': }
create-db { 'glance': }
create-db { 'keystone': }
create-db { 'nova': }
}
