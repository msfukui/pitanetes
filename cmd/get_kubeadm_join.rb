# frozen_string_literal: true

if node[:host][:master]

  host = node[:host][:name]
  user = node[:host][:user]

  token = (run_command "export KUBECONFIG=/home/#{user}/.kube/config && " \
           "kubeadm token list | head -2 | tail -1 | awk '{ print $1}'").stdout.strip

  hash = (run_command 'openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | ' \
    'openssl rsa -pubin -outform der 2>/dev/null | ' \
    "openssl dgst -sha256 -hex | sed 's/^.* //'").stdout.strip

  ip = (run_command "nslookup #{host} | tail -2 | head -1 | awk '{ print $2 }'").stdout.strip

  port = '6443'

  puts "kubeadm join --token #{token} " \
    "#{ip}:#{port} " \
    "--discovery-token-ca-cert-hash sha256:#{hash}"

end
