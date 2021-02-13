# frozen_string_literal: true

timezone = node[:host][:timezone]

execute "set timezone #{timezone}" do
  command "sudo timedatectl set-timezone #{timezone}"
end
