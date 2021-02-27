# frozen_string_literal: true

# Only worker node.

host = node[:host][:name]
user = node[:host][:user]

execute "kubectl label node #{host} node-role.kubernetes.io/worker=" do
  command "export KUBECONFIG=/home/#{user}/.kube/config && " \
    "kubectl label node #{host} node-role.kubernetes.io/worker= --overwrite"
end
