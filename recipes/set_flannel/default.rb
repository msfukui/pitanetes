# frozen_string_literal: true

if node[:host][:master]

  host = node[:host][:name]
  user = node[:host][:user]

  # Flannel's URL
  flannel_url = 'https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml'

  execute "kubectl apply -f #{flannel_url}" do
    command "export KUBECONFIG=/home/#{user}/.kube/config && " \
      "kubectl apply -f #{flannel_url}"
    not_if  "export KUBECONFIG=/home/#{user}/.kube/config && " \
      "kubectl get nodes | grep '#{host}' | grep 'Ready'"
  end

end
