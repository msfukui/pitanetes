# frozen_string_literal: true

require 'itamae/secrets'
node[:secrets] = Itamae::Secrets(File.join(__dir__, '..', '..', 'secrets'))
api_key = node[:secrets][:mackerel_api_key]
role    = node[:host][:role]

execute 'mackerel\'s setup' do
  command 'wget -q -O - https://mackerel.io/file/script/setup-apt-v2.sh | sh'
  not_if 'apt list mackerel-agent | grep "mackerel-agent"'
end

execute 'Update apt resources' do
  command 'sudo apt update -y'
end

# Install mackerel-agent
%w[
  mackerel-agent
].each do |p|
  package p do
    action :install
  end
end

template '/etc/mackerel-agent/mackerel-agent.conf' do
  action :create
  path '/etc/mackerel-agent/mackerel-agent.conf'
  source './templates/etc/mackerel-agent/mackerel-agent.conf.erb'
  mode '644'
  owner 'root'
  group 'root'
  variables(api_key: api_key, role: role)
end

service 'mackerel-agent' do
  action %i[start enable]
  subscribes :restart, 'template[/etc/mackerel-agent/mackerel-agent.conf]'
end
