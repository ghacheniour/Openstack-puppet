class swift::proxy-node::swift-ring-builder {
#swift-ring-builder-create { ['account', 'container', 'object']: }
$swift_drivers= hiera_array('swift_drivers')
#swift-ring-account-builder-add { $swift_drivers: }
#swift-ring-container-builder-add { $swift_drivers: }
#swift-ring-object-builder-add { $swift_drivers: }
 swift-ring-builder-rebalance { ['account', 'container', 'object']: }

}
