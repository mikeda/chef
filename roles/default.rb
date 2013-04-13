name "default"
description "Default"
run_list(
  "recipe[base]",
  "recipe[ntpd::client]",
  "recipe[munin::client]",
  "recipe[rbenv::mikeda]"
)
default_attributes(
  :variables => {
    :file_server_url => "http://192.168.1.110/files"
  }
)
