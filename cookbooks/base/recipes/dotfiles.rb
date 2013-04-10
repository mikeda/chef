users = %w(root mikeda sysadmin)

users.each do |user|
  home_dir = node[:etc][:passwd][user]['dir']

  %w(.tmux.conf .vimrc).each do |dotfile|
    cookbook_file "#{home_dir}/#{dotfile}" do
      source dotfile
      user user
      group user
      mode 00644
    end
  end

  cookbook_file "#{home_dir}/.bashrc" do
    source ".bashrc.#{user}"
    user user
    group user
    mode 00644
  end
end
