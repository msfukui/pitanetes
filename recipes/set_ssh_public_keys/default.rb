# frozen_string_literal: true

directory '.ssh' do
  action :create
  path '/home/ubuntu/.ssh'
  mode '700'
  owner 'ubuntu'
  group 'ubuntu'
end

remote_file 'authorized_keys' do
  action :create
  path '/home/ubuntu/.ssh/authorized_keys'
  source './files/.ssh/authorized_keys'
  mode '600'
  owner 'ubuntu'
  group 'ubuntu'
end
