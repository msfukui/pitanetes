# frozen_string_literal: true

# Uninstall old versions containerd.io
%w[
  docker
  docker-engine
  docker.io
  containerd
  runc
].each do |p|
  package p do
    action :remove
  end
end

# Install using the repository for containerd.io
%w[
  apt-transport-https
  ca-certificates
  curl
  gnupg-agent
  software-properties-common
].each do |p|
  package p do
    action :install
  end
end

execute 'Update apt resources' do
  command 'sudo apt update -y'
end

# Install containerd.io
%w[
  containerd.io
].each do |p|
  package p do
    action :install
  end
end
