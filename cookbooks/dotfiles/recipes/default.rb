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

login_users = data_bag('login_users')

login_users.each do |user|
  home = data_bag_item('login_users', user)['home']

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
