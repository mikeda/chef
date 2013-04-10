bash "reload_ld.so.conf" do
  user "root"
  code <<-EOH
    /sbin/ldconfig
  EOH
  action :nothing
end

cookbook_file '/etc/ld.so.conf.d/usr-local-lib.conf' do
  source 'usr-local-lib.conf'
  user 'root'
  group 'root'
  mode 00644
  notifies :run, "bash[reload_ld.so.conf]", :immediately
end
