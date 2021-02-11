# frozen_string_literal: true

service 'sshd' do
  subscribes :restart, 'remote_file[/etc/ssh/sshd_config]'
end

remote_file '/etc/ssh/sshd_config' do
  action :create
  path '/etc/ssh/sshd_config'
  source './files/etc/ssh/sshd_config'
  mode '644'
  owner 'root'
  group 'root'
end
