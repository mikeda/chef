package 'python-pip'

bash 'pip_install_supervisor' do
  user 'root'
  code <<-EOF
  pip-python install supervisor==#{node.supervisor.version}
  EOF
  creates '/usr/bin/supervisord'
end

directory '/etc/supervisord.d/' do
  owner 'root'
  group 'root'
  mode 00755
  action :create
end
directory '/var/log/supervisor/' do
  owner 'root'
  group 'root'
  mode 00755
  action :create
end

cookbook_file '/etc/init.d/supervisord' do
  source 'supervisord.init'
  owner 'root'
  group 'root'
  mode 0755
  action :create_if_missing
end

template "/etc/supervisord.conf" do
  source "supervisord.conf.erb"
  mode 0644
end

service "supervisord" do
  action [:enable, :start]
end

execute "supervisorctl update" do
  action :nothing
  user "root"
end
