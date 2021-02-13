# frozen_string_literal: true

service 'systemd-timesyncd' do
  subscribes :restart, 'remote_file[/etc/systemd/timesyncd.conf]'
end

remote_file '/etc/systemd/timesyncd.conf' do
  action :create
  path '/etc/systemd/timesyncd.conf'
  source './files/etc/systemd/timesyncd.conf'
  mode '644'
  owner 'root'
  group 'root'
end
