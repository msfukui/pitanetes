# frozen_string_literal: true

# c.f. https://metallb.universe.tf/installation/

user = node[:host][:user]
loadbalancer_ip_range = node[:metallb][:loadbalancer_ip_range]

# Metallb's manifest URL
metallb_ns_url = 'https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml'
metallb_url    = 'https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml'

execute 'Preparation: editing kube-proxy config' do
  command 'echo edited.'
  only_if 'kubectl get configmap kube-proxy -n kube-system -o yaml | ' \
    'sed -e "s/strictARP: false/strictARP: true/" | ' \
    'kubectl diff -f - -n kube-system'
  not_if  "export KUBECONFIG=/home/#{user}/.kube/config && " \
    "kubectl get pods --all-namespaces | grep 'metallb-system'"
end

execute 'Installration: kubectl apply -f metallb_ns_url, metallb_url' do
  command "export KUBECONFIG=/home/#{user}/.kube/config && " \
    "kubectl apply -f #{metallb_ns_url} && kubectl apply -f #{metallb_url} && " \
    'kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"'
  not_if  "export KUBECONFIG=/home/#{user}/.kube/config && " \
    "kubectl get pods --all-namespaces | grep 'metallb-system'"
end

directory "/home/#{user}/manifests/pitanetes/metallb" do
  action :create
  path "/home/#{user}/manifests/pitanetes/metallb"
  mode '750'
  owner user
  group user
end

template "/home/#{user}/manifests/pitanetes/metallb/MetalLB-L2.yml" do
  action :create
  path "/home/#{user}/manifests/pitanetes/metallb/MetalLB-L2.yml"
  source './templates/manifests/pitanetes/metallb/MetalLB-L2.yml.erb'
  mode '640'
  owner user
  group user
  variables(loadbalancer_ip_range: loadbalancer_ip_range)
end

execute 'Configuration: kubectl apply -f MetalLB-L2.yml' do
  command "export KUBECONFIG=/home/#{user}/.kube/config && " \
    "kubectl apply -f /home/#{user}/manifests/pitanetes/metallb/MetalLB-L2.yml"
  subscribes :run, "template[/home/#{user}/manifests/pitanetes/metallb/MetalLB-L2.yml]"
  action :nothing
end
