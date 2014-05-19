define create-disk-partition {

exec { "create-partition-$name":
  command => "/bin/cat <<EOF | /sbin/fdisk /dev/$name
n
p
1


w
EOF",
}
}
