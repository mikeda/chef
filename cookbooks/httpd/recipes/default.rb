[ "httpd", "httpd-devel"].each do |pkg|
  package pkg
end

directory '/var/log/httpd/' do
  mode 00755
end

['/etc/httpd/conf.d/welcome.conf', '/etc/httpd/conf.d/README'].each do |f|
  file f do
    action :delete
  end
end

service "httpd" do
  supports :restart => true, :reload => true
  action [ :enable, :start ]
end

template "/etc/httpd/conf/httpd.conf" do
  owner  "root"
  group  "root"
  mode   00644
  notifies :restart, resources(:service => "httpd")
end
