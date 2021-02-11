# frozen_string_literal: true

if node[:host][:master]

  user = node[:host][:user]

  # Flannel's URL
  flannel_url = 'https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml'

  execute "kubectl apply -f #{flannel_url}" do
    command "export KUBECONFIG=/home/#{user}/.kube/config && " \
      "kubectl apply -f #{flannel_url}"
    not_if  "export KUBECONFIG=/home/#{user}/.kube/config && " \
      "kubectl get nodes | grep '#{node[:host][:name]}' | grep 'Ready'"
  end

end
