# frozen_string_literal: true

user = node[:host][:user]

execute "Use docker in #{user}" do
  command "sudo usermod -aG docker #{user}"
end

remote_file '/etc/docker/daemon.json' do
  action :create
  path '/etc/docker/daemon.json'
  source './files/etc/docker/daemon.json'
  mode '644'
  owner 'root'
  group 'root'
end

directory '/etc/systemd/system/docker.service.d' do
  action :create
  path '/etc/systemd/system/docker.service.d'
  mode '755'
  owner 'root'
  group 'root'
end

execute 'systemctl daemon-reload' do
  command 'sudo systemctl daemon-reload'
  subscribes :run, 'remote_file[/etc/docker/daemon.json]'
  subscribes :run, 'directory[/etc/systemd/system/docker.service.d]'
  action :nothing
end

service 'docker' do
  subscribes :restart, 'remote_file[/etc/docker/daemon.json]'
  subscribes :restart, 'directory[/etc/systemd/system/docker.service.d]'
end
