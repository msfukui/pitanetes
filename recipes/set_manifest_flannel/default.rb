# frozen_string_literal: true

host = node[:host][:name]
user = node[:host][:user]

# Flannel's manifest URL
flannel_url = 'https://raw.githubusercontent.com/flannel-io/flannel/v0.16.3/Documentation/kube-flannel.yml'

execute "kubectl apply -f #{flannel_url}" do
  command "export KUBECONFIG=/home/#{user}/.kube/config && " \
    "kubectl apply -f #{flannel_url}"
  not_if  "export KUBECONFIG=/home/#{user}/.kube/config && " \
    "kubectl get nodes | grep '#{host}' | grep 'Ready'"
end
