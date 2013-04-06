name "default"
description "Default"
run_list "recipe[ntpd::client]",
         "recipe[munin::client]",
         "recipe[dotfiles]"
