include_recipe "mysql::client"

package "MySQL-server" do
  version node[:mysql][:version]
  action :install
end

package "percona-toolkit"

["/var/run/mysqld/", "/var/log/mysql/"].each do |dir|
  directory dir do
    owner  "mysql"
    group  "mysql"
    mode    00755
    action :create
  end
end

# TODO:複数バージョン対応
template "/etc/my.cnf" do
  source "my.cnf.55.erb"
  owner  "mysql"
  group  "mysql"
  mode   00644
  variables({
    :server_id => sprintf("%d%03d%03d", *node[:ipaddress].split(".")[1..3])
  })
end

cookbook_file "/etc/logrotate.d/mysql" do
  source "logrotate.mysql"
  mode 00644
end

service "mysql" do
  action [ :enable, :start ]
end
