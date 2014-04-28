#!/bin/sh
sudo puppet apply /root/puppet/manifests/site.pp --modulepath=/root/puppet/modules/ $* --hiera_config=/root/puppet/hiera.yaml $*
