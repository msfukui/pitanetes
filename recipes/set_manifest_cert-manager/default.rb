# frozen_string_literal: true

# c.f. https://cert-manager.io/docs/installation/kubernetes/

user = node[:host][:user]

# cert-manager's manifest URL
cert_manager_url = 'https://github.com/jetstack/cert-manager/releases/download/v1.8.0/cert-manager.yaml'

execute 'Installration: kubectl apply -f cert-manager_url' do
  command "export KUBECONFIG=/home/#{user}/.kube/config && " \
    "kubectl apply -f #{cert_manager_url}"
  not_if  "export KUBECONFIG=/home/#{user}/.kube/config && " \
    "kubectl get pods --namespace cert-manager | grep 'cert-manager'"
end
