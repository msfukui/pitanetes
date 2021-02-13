# frozen_string_literal: true

# Only worker node.
unless node[:host][:master]

  host = node[:host][:name]
  user = node[:host][:user]

  join_file = '.pitanetes_k8s_master_join'
  h = {}
  File.open(join_file) do |j|
    h = JSON.parse(j.read)
  end

  config_file = '.pitanetes_k8s_master_config'

  execute "kubeadm join in #{host}" do
    command "sudo kubeadm join #{h['ip']}:#{h['port']} " \
      "--token #{h['token']} " \
      "--discovery-token-ca-cert-hash sha256:#{h['hash']}"
    not_if "export KUBECONFIG=/home/#{user}/.kube/config && " \
      "kubectl get nodes | grep '#{host}'"
  end

  directory "/home/#{user}/.kube" do
    action :create
    path "/home/#{user}/.kube"
    mode '700'
    owner user
    group user
  end

  remote_file "/home/#{user}/.kube/config" do
    action :create
    path "/home/#{user}/.kube/config"
    source "../../#{config_file}"
    mode '600'
    owner user
    group user
  end

end
