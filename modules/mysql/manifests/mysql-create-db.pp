#class that creates databeses for all openstack services
class mysql::mysql-create-db () {
  require mysql::mysql-install
  create-db { 'cinder': }
  create-db { 'neutron': }
  create-db { 'glance': }
  create-db { 'keystone': }
  create-db { 'nova': }
  create-db { 'heat': }
}
