name "linux"
description "Linux"
run_list "recipe[dotfiles]", "recipe[munin::client]"
