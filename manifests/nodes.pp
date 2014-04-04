node 'master' {
   file { '/tmp/hello':
           content => "hello, world\n",
        }
    }
