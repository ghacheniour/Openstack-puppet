define sed-sysctl ( $attribute, $new_attribute, $path ) {
  exec { $name:
    command => "/bin/sed -i -e 's/^$attribute/$new_attribute/g' ${path}",
  }
} 
