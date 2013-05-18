include_recipe 'munin::client'
include_recipe 'httpd'

['munin', 'munin-cgi'].each do |pkg|
  package pkg
end

template '/etc/munin/munin.conf' do
  mode 0644
end

template '/etc/munin/plugin-conf.d/snmp' do
  source 'plugin-conf.d/snmp.erb'
  mode 0644
  notifies :restart, resources(:service => 'munin-node')
end

node[:munin][:server][:links].each do |target, to|
  link "/etc/munin/plugins/#{target}" do
    owner 'root'
    group 'root'
    to "/usr/share/munin/plugins/#{to}"
    notifies :restart, resources(:service => 'munin-node')
  end
end

template '/etc/httpd/conf.d/munin.conf' do
  source 'httpd/munin.conf.erb'
  mode 0644
  notifies :reload, resources(:service => "httpd")
end

template '/etc/httpd/conf.d/munin-cgi.conf' do
  source 'httpd/munin-cgi.conf.erb'
  mode 0644
  notifies :reload, resources(:service => "httpd")
end
