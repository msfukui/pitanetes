# frozen_string_literal: true

if node[:host][:master]

  user = node[:host][:user]

  # from master node's ~/.kube/config

  config = (run_command "cat /home/#{user}/.kube/config").stdout.strip

  # to worker node's ~/.kube/config

  puts config

end
