class heat::install-heat-packages {
  package { ['heat-api', 
             'heat-api-cfn',
             'heat-engine']:
    ensure => installed,
}


}
