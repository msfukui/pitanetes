# frozen_string_literal: true

# Uninstall old versions docker
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

# Install using the repository for Docker
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

execute 'Add Docker\'s official GPG key' do
  command 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -'
end

execute 'Set up the stable repository for Docker' do
  command \
    'sudo add-apt-repository ' \
    '"deb [arch=arm64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"'
end

execute 'Update apt resources' do
  command 'sudo apt update -y'
end

# Install Docker Engine
%w[
  docker-ce
  docker-ce-cli
  containerd.io
].each do |p|
  package p do
    action :install
  end
end

execute 'Hold docker\'s version' do
  command 'sudo apt-mark hold docker-ce docker-ce-cli containerd.io'
end
