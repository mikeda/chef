#
# Cookbook Name:: sample
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/tmp/chef-sample.txt" do
  source "chef-sample.txt.erb"
  mode 0644
end
