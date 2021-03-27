# frozen_string_literal: true

# get all etc/hosts list
hosts = []
Dir.glob('nodes/*.json') do |f|
  j = JSON.parse(File.open(f).read)
  hosts = j['etc']['hosts'] if j['host']['master']
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
