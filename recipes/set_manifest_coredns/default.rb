# frozen_string_literal: true

# c.f. https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/
# https://coredns.io/plugins/hosts/
# https://coredns.io/2017/05/08/custom-dns-entries-for-kubernetes/
# https://qiita.com/teruq/items/8f9c608aba385d06f9b9

user = node[:host][:user]
hosts = node[:etc][:hosts]

directory "/home/#{user}/manifests/pitanetes/coredns" do
  action :create
  path "/home/#{user}/manifests/pitanetes/coredns"
  mode '750'
  owner user
  group user
end

template "/home/#{user}/manifests/pitanetes/coredns/corefile.yml" do
  action :create
  path "/home/#{user}/manifests/pitanetes/coredns/corefile.yml"
  source './templates/manifests/pitanetes/coredns/corefile.yml.erb'
  mode '640'
  owner user
  group user
  variables(hosts: hosts)
end

execute 'Installration: kubectl apply -f corefile.yml' do
  command "export KUBECONFIG=/home/#{user}/.kube/config && " \
    "kubectl apply -f /home/#{user}/manifests/pitanetes/coredns/corefile.yml"
  subscribes :run, "template[/home/#{user}/manifests/pitanetes/coredns/corefile.yml]"
  action :nothing
end
