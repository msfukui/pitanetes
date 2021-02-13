# frozen_string_literal: true

if node[:host][:master]

  host = node[:host][:name]
  user = node[:host][:user]
  join = {}

  join[:token] = (run_command "export KUBECONFIG=/home/#{user}/.kube/config && " \
                  "kubeadm token list | head -2 | tail -1 | awk '{ print $1}'").stdout.strip

  if join[:token].empty?
    join[:token] = (run_command "export KUBECONFIG=/home/#{user}/.kube/config && " \
                    'kubeadm token create').stdout.strip
  end

  join[:hash] = (run_command 'openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | ' \
                 'openssl rsa -pubin -outform der 2>/dev/null | ' \
                 "openssl dgst -sha256 -hex | sed 's/^.* //'").stdout.strip

  join[:ip] = (run_command "nslookup #{host} | tail -2 | head -1 | awk '{ print $2 }'").stdout.strip

  join[:port] = '6443'

  # kubeadm join --token #{join[:token]} " \
  #   #{join[:ip]}:#{join[:port]} " \
  #   --discovery-token-ca-cert-hash sha256:#{join[:hash]}

  puts JSON.pretty_generate(join)

end
