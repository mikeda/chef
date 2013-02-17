nodejs_version = node.proteus_monitor.nodejs.version
base_dir       = node.proteus_monitor.base_dir
exec_user      = node.proteus_monitor.exec_user

tgz_name = "node-v#{nodejs_version}-linux-x64.tar.gz"
tgz_path = "#{base_dir}/#{tgz_name}"
tgz_download_url = "http://nodejs.org/dist/v#{nodejs_version}/#{tgz_name}"
extract_path = "#{base_dir}/node-v#{nodejs_version}-linux-x64"

directory base_dir do
  owner exec_user
  group exec_user
  mode 00755
  action :create
  recursive true
end

remote_file tgz_path do
  source tgz_download_url
  mode 0644
  action :create_if_missing
end

bash 'extract_tarball' do
  user exec_user
  cwd base_dir
  code <<-EOF
  tar xzf #{tgz_path}
  EOF
  not_if { File.exist?(extract_path) }
end

link "#{base_dir}/node" do
  owner exec_user
  group exec_user
  to extract_path
end
