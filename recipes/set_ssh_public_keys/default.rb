# frozen_string_literal: true

user = node[:host][:user]

directory "/home/#{user}/.ssh" do
  action :create
  path "/home/#{user}/.ssh"
  mode '700'
end

remote_file "/home/#{user}/.ssh/authorized_keys" do
  action :create
  path "/home/#{user}/.ssh/authorized_keys"
  source './files/.ssh/authorized_keys'
  mode '600'
end
