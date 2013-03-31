include_recipe "java::jre"

['dsc12', 'jna'].each do |pkg|
  package pkg
end

service "cassandra" do
  action :enable
end

template "/etc/cassandra/conf/cassandra.yaml" do
  source "cassandra.yaml.erb"
  owner  "cassandra"
  group  "cassandra"
  mode   00644
end
