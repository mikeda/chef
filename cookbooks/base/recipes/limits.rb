[ '/etc/security/limits.conf', '/etc/security/limits.d/90-nproc.conf' ].each do |path|
  cookbook_file path do
    user 'root'
    group 'root'
    mode 00644
  end
end
