include_recipe 'httpd'

['nagios', 'nagios-plugins-all', 'nagios-plugins-nrpe'].each do |pkg|
  package pkg
end

service "nagios" do
  supports :reload => true, :restart => true
  action [:enable, :start]
end

%w(nagios cgi).each do |cfg|
  template "/etc/nagios/#{cfg}.cfg" do
    owner 'root'
    group 'root'
    notifies :reload, resources(:service => "nagios")
  end
end

%w(localhost printer switch windows).each do |cfg|
  file "/etc/nagios/objects/#{cfg}.cfg" do
    action :delete
  end
end

%w(commands contacts hostgroups hosts services templates timeperiods).each do |cfg|
  template "/etc/nagios/objects/#{cfg}.cfg" do
    source "objects/#{cfg}.cfg.erb"
    owner 'root'
    group 'root'
    mode  0644
    notifies :reload, resources(:service => "nagios")
  end
end

template '/etc/httpd/conf.d/nagios.conf' do
  source "httpd/nagios.conf.erb"
  notifies :reload, resources(:service => "httpd")
end
