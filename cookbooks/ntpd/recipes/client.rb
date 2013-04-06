template "/etc/ntp.conf" do
  source "ntp.conf.client.erb"
  owner  "root"
  group  "root"
  mode   00644
  notifies :restart, "service[ntpd]"
end

service "ntpd" do
  action [:enable, :start]
end
