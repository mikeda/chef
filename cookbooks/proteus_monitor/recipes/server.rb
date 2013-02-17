include_recipe "proteus_monitor::nodejs"
include_recipe "supervisor::default"

exec_user = node.proteus_monitor.exec_user
install_dir = node.proteus_monitor.server.install_dir
npm_command = "#{node.proteus_monitor.nodejs.install_dir}/bin/npm"
node_command = "#{node.proteus_monitor.nodejs.install_dir}/bin/node"

git install_dir do
  repository node.proteus_monitor.server.repository
  action :sync
  user exec_user
  group exec_user
end

bash 'install_proteus-monitor-server' do
  user exec_user
  cwd install_dir
  environment ({ 'HOME' => "/home/#{exec_user}" })
  code <<-EOF
  #{npm_command} install
  EOF
  creates "#{install_dir}/node_modules"
end

template '/etc/supervisord.d/proteus-monitor-server.ini' do
  source 'server.supervisord.ini.erb'
  owner 'root'
  group 'root'
  mode 0644
end

bash 'supervisorctl update' do
  user 'root'
  code <<-EOF
  supervisorctl update
  EOF
  not_if 'supervisorctl status proteus-monitor-server | grep RUNNING'
end
