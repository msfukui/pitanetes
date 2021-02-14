# frozen_string_literal: true

user = node[:host][:user]

remote_file "/home/#{user}/.bashrc" do
  action :create
  path "/home/#{user}/.bashrc"
  source './files/dot.bashrc'
  mode '644'
  owner user
  group user
end
