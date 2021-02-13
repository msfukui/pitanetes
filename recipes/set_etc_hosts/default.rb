# frozen_string_literal: true

remote_file '/etc/hosts' do
  action :create
  path '/etc/hosts'
  source './files/etc/hosts'
  mode '644'
  owner 'root'
  group 'root'
end
