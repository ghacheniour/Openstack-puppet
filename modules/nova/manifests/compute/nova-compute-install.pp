class nova::compute::nova-compute-install {
require mysql::compute::mysql-lib
package { ['nova-compute-kvm', 'python-guestfs']: ensure => installed, }


}
