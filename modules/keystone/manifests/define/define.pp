class keystone::define::define {  
require keystone::install::install
  $admin_token = hiera('admin_token')
  $group = ["keystone", "glance", "cinder", "nova", "neutron"]
  $hostname = hiera('hostname')
  $url = "http://${hostname}:35357/v2.0"
  creditionals { 'create-source-file': }
  tenant-create { 'create-tenant-admin':
    admin_token => $admin_token, 
    url => $url,
    tenant_name => "admin",
    desc => "tenant admin",
    require => Creditionals['create-source-file'],
  }
  tenant-create { 'create-tenant-service':
    admin_token => $admin_token,
    url => $url,
    tenant_name => "service",
    desc => "tenant service",
    require => Creditionals['create-source-file'],
  }
  role-create { 'create-role-admin':
    admin_token => $admin_token,
    url => $url,
    role => "admin",
    require => Creditionals['create-source-file'],
  }

  user-create { ['keystone', 'glance', 'cinder', 'nova', 'neutron','swift','heat']:
    admin_token => $admin_token,
    url => $url,
    require => Creditionals['create-source-file'],
  }
  usr-role-add { 'admin':
    admin_token => $admin_token,
    url => $url,
    tenant => admin ,
    role => admin ,
    require => [User-create['keystone'], Role-create['create-role-admin'], Tenant-create['create-tenant-admin']],
  }
  usr-role-add { 'glance':
    admin_token => $admin_token,
    url => $url,
    tenant => "service" ,
    role => "admin" ,
    require => [User-create['glance'], Role-create['create-role-admin'], Tenant-create['create-tenant-service']],
  }
  usr-role-add { 'nova':
    admin_token => $admin_token,
    url => $url,
    tenant => "service" ,
    role => "admin" ,
    require => [User-create['nova'], Role-create['create-role-admin'], Tenant-create['create-tenant-service']],
  }
  usr-role-add { 'cinder':
    admin_token => $admin_token,
    url => $url,
    tenant => "service",
    role => "admin",
    require => [User-create['cinder'], Role-create['create-role-admin'], Tenant-create['create-tenant-service']],
  }
  usr-role-add { 'neutron':
    admin_token => $admin_token,
    url => $url,
    tenant => "service",
    role => "admin",
    require => [User-create['neutron'], Role-create['create-role-admin'], Tenant-create['create-tenant-service']],
  }
 usr-role-add { 'swift':
    admin_token => $admin_token,
    url => $url,
    tenant => "service",
    role => "admin",
    require => [User-create['swift'], Role-create['create-role-admin'], Tenant-create['create-tenant-service']],
  }
 usr-role-add { 'heat':
    admin_token => $admin_token,
    url => $url,
    tenant => "service",
    role => "admin",
    require => [User-create['heat'], Role-create['create-role-admin'], Tenant-create['create-tenant-service']],
  }
}
