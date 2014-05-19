class swift::storage-node::install-swift-package {
package { ['swift-account', 'swift-container', 'swift-object', 'xfsprogs']:
  ensure => installed,
}
}
