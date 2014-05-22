define sed-heat ($attribute, $new_attribute){
exec { $name:
  command => "/bin/sed -i -e 's/^$attribute/$new_attribute/g' /etc/heat/heat.conf",
}
}
