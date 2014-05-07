class nova::compute::nova-compute-install {
package { ['nova-compute-kvm', 'python-guestfs']: ensure => installed, }


}
