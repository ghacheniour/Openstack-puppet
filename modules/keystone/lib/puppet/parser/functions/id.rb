module Puppet::Parser::Functions
      newfunction(:id, :type => :rvalue) do |args|
        token = args[0]
        url = args[1]
        service = args[2]
        x = `/usr/bin/keystone --os-token=#{token}  --os-endpoint=#{url}  service-list  | grep #{service} | awk '{print $2}'`
      end
    end
