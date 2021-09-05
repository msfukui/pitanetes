# frozen_string_literal: true

# Set up CoreDNS for internal DNS
# NOTE: It's completely different from the CoreDNS settings used for name resolution inside Kubernetes.

user = node[:host][:user]
dnsservers = node[:coredns][:dnsservers]
locals = node[:coredns][:locals]

directory "/home/#{user}/conf/pitanetes/coredns" do
  action :create
  path "/home/#{user}/conf/pitanetes/coredns"
  mode '750'
  owner user
  group user
end

# No need to restart CoreDNS because the reload plugin is included.
template "/home/#{user}/conf/pitanetes/coredns/Corefile" do
  action :create
  path "/home/#{user}/conf/pitanetes/coredns/Corefile"
  source './templates/conf/pitanetes/coredns/Corefile.erb'
  mode '640'
  owner user
  group user
  variables(dnsservers: dnsservers, locals: locals)
end

remote_file '/etc/systemd/resolved.conf' do
  action :create
  path '/etc/systemd/resolved.conf'
  source './files/etc/systemd/resolved.conf'
  mode '644'
  owner 'root'
  group 'root'
end

execute 'Ignore systemd-resolved' do
  command 'sudo rm /etc/resolv.conf && ' \
    'sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf && ' \
    'sudo systemctl restart systemd-resolved'
end

execute 'Start CoreDNS' do
  command "docker run -d --rm -v /home/#{user}/conf/pitanetes/coredns/:/root/ " \
    '--name coredns -p 53:53/udp coredns/coredns -conf /root/Corefile'
  not_if 'docker ps -f name=coredns -f publish=53/udp -q | grep "[0-9|a-z]"'
end
