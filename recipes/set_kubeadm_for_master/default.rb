# frozen_string_literal: true

if node[:host][:master]

  host = node[:host][:name]
  user = node[:host][:user]

  # CIDR for Flannel
  pod_network_cidr = '10.244.0.0/16'

  execute "kubeadm init in #{host}" do
    command "sudo kubeadm init --pod-network-cidr=#{pod_network_cidr}"
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

  execute 'copy /etc/kubernetes/admin.conf' do
    command "cp /etc/kubernetes/admin.conf /home/#{user}/.kube/config && " \
      "sudo chown #{user}:#{user} /home/#{user}/.kube/config && " \
      "chmod 600 /home/#{user}/.kube/config"
    not_if "cmp -s /etc/kubernetes/admin.conf /home/#{user}/.kube/config"
  end

end
