include_recipe "proteus_monitor::nodejs"
include_recipe "supervisor::default"

exec_user = node.proteus_monitor.exec_user
install_dir = node.proteus_monitor.agent.install_dir
npm_command = "#{node.proteus_monitor.nodejs.install_dir}/bin/npm"
node_command = "#{node.proteus_monitor.nodejs.install_dir}/bin/node"

git install_dir do
  repository node.proteus_monitor.agent.repository
  action :sync
  user exec_user
  group exec_user
end

bash 'install_proteus-monitor-agent' do
  user exec_user
  cwd install_dir
  environment ({ 'HOME' => "/home/#{exec_user}" })
  code <<-EOF
  #{npm_command} install
  EOF
  creates "#{install_dir}/node_modules"
end

execute "supervisorctl restart proteus-monitor-agent" do
  action :nothing
  user "root"
end

file node.proteus_monitor.agent.config do
  owner exec_user
  group exec_user
  mode 0644
  content JSON.pretty_generate({
    host: "#{node.proteus_monitor.server.host}:#{node.proteus_monitor.server.port}",
    group: node.proteus_monitor.agent.group,
    plugins: node.proteus_monitor.agent.plugins
  })
  notifies :run, resources(:execute => "supervisorctl restart proteus-monitor-agent")
end

template '/etc/supervisord.d/proteus-monitor-agent.ini' do
  source 'agent.supervisord.ini.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :run, resources(:execute => "supervisorctl update")
end
