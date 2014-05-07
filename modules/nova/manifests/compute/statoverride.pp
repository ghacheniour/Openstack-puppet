define statoverride {
  exec { $name:
    command => "/usr/bin/dpkg-statoverride  --update --add root root 0644 /boot/vmlinuz-$(uname -r)",
  }
}
