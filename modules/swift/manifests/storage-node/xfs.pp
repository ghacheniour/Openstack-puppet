define xfs {
$path = "${name}1"
exec { "make-xfs-partition-$name":
  command => "/sbin/mkfs.xfs -f /dev/$path",
}->
exec { "echo-$path":
  command => "/bin/echo \"/dev/$path /srv/node/$path xfs noatime,nodiratime,nobarrier,logbufs=8 0 0\" >> /etc/fstab",
}->
file { "/srv/node/$path":
  ensure => directory,
}->
exec { "mount-$name":
  command => "/bin/mount /srv/node/$path",
}

}
