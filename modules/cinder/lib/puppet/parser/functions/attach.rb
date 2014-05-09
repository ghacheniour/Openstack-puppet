module Puppet::Parser::Functions
      newfunction(:attach, :type => :rvalue) do |args|
        path = args[0]
        `pvcreate #{path} && vgcreate  cinder-volumes #{path}`
      end
    end
