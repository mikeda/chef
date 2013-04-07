["MySQL-client", "MySQL-devel", "MySQL-shared", "MySQL-shared-compat"].each do |pkg|
  package pkg do
    version node[:mysql][:version]
    action :install
  end
end
