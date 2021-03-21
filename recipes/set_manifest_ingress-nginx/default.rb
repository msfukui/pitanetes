# frozen_string_literal: true

# c.f. https://kubernetes.github.io/ingress-nginx/deploy/
#      https://kubernetes.github.io/ingress-nginx/deploy/baremetal/
#
# ingress-nginx's manifest URL
# https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.44.0/deploy/static/provider/baremetal/deploy.yaml

user = node[:host][:user]
loadbalancer_ip = node[:ingress_nginx][:loadbalancer_ip]

directory "/home/#{user}/manifests/pitanetes/ingress-nginx" do
  action :create
  path "/home/#{user}/manifests/pitanetes/ingress-nginx"
  mode '750'
  owner user
  group user
end

template "/home/#{user}/manifests/pitanetes/ingress-nginx/deploy.yaml" do
  action :create
  path "/home/#{user}/manifests/pitanetes/ingress-nginx/deploy.yaml"
  source './templates/manifests/pitanetes/ingress-nginx/deploy.yaml.erb'
  mode '640'
  owner user
  group user
  variables(loadbalancer_ip: loadbalancer_ip)
end

execute 'Installration: kubectl apply -f deploy.yaml' do
  command "export KUBECONFIG=/home/#{user}/.kube/config && " \
    "kubectl apply -f /home/#{user}/manifests/pitanetes/ingress-nginx/deploy.yaml"
  subscribes :run, "template[/home/#{user}/manifests/pitanetes/ingress-nginx/deploy.yaml]"
  action :nothing
end
