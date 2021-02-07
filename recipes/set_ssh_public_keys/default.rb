# frozen_string_literal: true

directory '.ssh' do
  action :create
  path "/home/#{node[:host][:user]}/.ssh"
  mode '700'
end

remote_file 'authorized_keys' do
  action :create
  path "/home/#{node[:host][:user]}/.ssh/authorized_keys"
  source './files/.ssh/authorized_keys'
  mode '600'
end
