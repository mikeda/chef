#
# Cookbook Name:: dotfiles
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'git' do
  action :install
end

login_users = [ 'mikeda', 'sysadmin' ]

login_users.each do |user|
  home = "/home/#{user}"

  git "#{home}/.dotfiles" do
    repository node['dotfiles']['repository']
    action :sync
    user user
    group user
  end

  node['dotfiles']['files'].each do |file|
    link "#{home}/#{file}" do
      owner user
      group user
      to "#{home}/.dotfiles/#{file}"
    end
  end
end
