package "munin-node"

service "munin-node" do
  supports :restart => true
  action :enable
end

template "/etc/munin/munin-node.conf" do
  source "munin-node.conf.erb"
  mode 0644
  notifies :restart, resources(:service => "munin-node")
end
