name "default"
description "Default"
run_list "recipe[base]",
         "recipe[ntpd::client]",
         "recipe[munin::client]"
