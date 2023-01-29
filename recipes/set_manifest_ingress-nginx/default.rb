# frozen_string_literal: true

# c.f. https://kubernetes.github.io/ingress-nginx/deploy/
#      https://kubernetes.github.io/ingress-nginx/deploy/baremetal/
#
# ingress-nginx's manifest URL
# https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.5.1/deploy/static/provider/cloud/deploy.yaml

user = node[:host][:user]

deploy_url = 'https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.5.1/deploy/static/provider/cloud/deploy.yaml'

execute 'Installration: kubectl apply -f deploy.yaml' do
  command "export KUBECONFIG=/home/#{user}/.kube/config && " \
    "kubectl apply -f #{deploy_url}"
end
