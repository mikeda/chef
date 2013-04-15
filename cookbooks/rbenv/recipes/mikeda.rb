user = "mikeda"
tar_file = "rbenv_#{user}.tgz"
home = "/home/#{user}"

%w(libxml2 libxml2-devel libxslt libxslt-devel).each do |pkg|
  package pkg
end

remote_file "#{home}/#{tar_file}" do
  source "#{node.variables.file_server_url}/ruby/#{tar_file}"
  mode 00755
  not_if { File.exists?("#{home}/.rbenv/bin") || File.exists?("#{home}/#{tar_file}") }
end

bash "install_rbenv" do
  user user
  cwd home
  environment ({ 'HOME' => home })
  code <<-EOL
    tar xzf #{home}/#{tar_file}
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
  EOL
  creates "#{home}/.rbenv/bin"
end
