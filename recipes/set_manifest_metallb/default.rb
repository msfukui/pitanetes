# frozen_string_literal: true

# c.f. https://metallb.universe.tf/installation/

user = node[:host][:user]

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

remote_file "/home/#{user}/MetalLB-L2.yml" do
  action :create
  path "/home/#{user}/MetalLB-L2.yml"
  source './files/MetalLB-L2.yml'
  mode '644'
  owner user
  group user
end

execute "Configuration: kubectl apply -f /home/#{user}/L2.yml" do
  command 'echo applied.'
  only_if "export KUBECONFIG=/home/#{user}/.kube/config && " \
    "kubectl apply -f /home/#{user}/L2.yml"
end
