# frozen_string_literal: true

execute "set timezone #{node[:host][:timezone]}" do
  command "sudo timedatectl set-timezone #{node[:host][:timezone]}"
end
