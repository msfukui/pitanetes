# frozen_string_literal: true

# get all node's list
hosts = []
Dir.glob('nodes/*.json') do |f|
  j = JSON.parse(File.open(f).read)
  hosts << j['host']
end

template '/etc/hosts' do
  action :create
  path '/etc/hosts'
  source './templates/etc/hosts.erb'
  mode '644'
  owner 'root'
  group 'root'
  variables(hosts: hosts)
end
