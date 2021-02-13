# frozen_string_literal: true

# Install using the repository for Kubernetes
%w[
  apt-transport-https
  curl
].each do |p|
  package p do
    action :install
  end
end

execute 'Add Kubernetes\'s official GPG key' do
  command 'curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -'
end

execute 'Set up the stable repository for Kubernetes' do
  command 'echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" ' \
    '| sudo tee /etc/apt/sources.list.d/kubernetes.list'
end

execute 'Update apt resources' do
  command 'sudo apt update -y'
end

# Install kubelet, kubeadm and kubectl
%w[
  kubelet
  kubeadm
  kubectl
].each do |p|
  package p do
    action :install
  end
end

execute 'Hold kubernetes\'s version' do
  command 'sudo apt-mark hold kubelet kubeadm kubectl'
end
